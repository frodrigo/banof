# Constitution d'une base d'adresses nationale française libre basée sur le cadastre, les données en OpenData et d'OpenStreetMap.
Ces trois sources de données sont mise en correspondance.

## Principe global

Les donnes sont extraites du cadastre vectoriel en ligne avec l'outil [export-cadastre](https://github.com/osm-fr/export-cadastre). Elles sont mises en correspondance avec le [FANTOIR](https://www.data.gouv.fr/fr/dataset/fichier-fantoir-des-voies-et-lieux-dits).

Les données adresses sont extraites d'OpenStreetMap, puis retraitées et consolidées pour être toutes sous la même forme.

L'ensemble de ces sources des données sont ensuite mise en correspondance suivant différents critères et priorités (FANTOIR, noms de voies, noms approximatifs...).
Il en est ensuite de même pour les numéros de rues.

Après la mise en correspondance les données sont exportées, cela comprend de façon unique les données retrouvées dans plusieurs jeux de données, mais aussi celles sans correspondances.

## Cadastre

De l'extraction du cadastre résulte un fichier .osm par commune avec une relation associatedStreet par voie. Les noms de voies sont au format du cadastre, c’est-à-dire en majuscule et avec des abréviations.

Ces fichiers .osm sont converti en deux fichiers csv : un pour les voie, l'autre pour les numéros. Ces deux listes sont chargées en base de données.

Parallèlement le CSV du FANTOIR est aussi mis en base de données. Bien que le FANTOIR et le cadastre soient tous les deux produits par la même entité ils ne correspondent pas totalement, ils ne sont pas exactement de la même date. À noter que le FANTOIR n'est pas géolocaliser, il donne les codes, types et noms de voies des communes.

La mise en correspondance du cadastre et du FANTOIR est fait par commune suivant 4 niveaux de confidence.

1. le nom est strictement identique,
2. le nom à un écart de 1 caractère,
3. le nom canonisé (voir la canonisation dans le dernier paragraphe) est strictement identique,
4. le nom canonisé à un écart de 1 caractère.
Cette mise en correspondance est enregistré dans une table.

Dernière étape du traitement des données du cadastre : les numéros de rues sont séparés de leur extension (bis, ter, A, B, C, D...) et seule la première lettre de l'extension mise en majuscule est conservé. Pour finir un polygone englobant des adresses est créé par voie.

## OpenData
TODO

## OpenStreetMap

Les polygones des communes de France sont mise en base de données (polygones issue d'OSM).

Depuis un extract France, avec Osmosis sont extraite puis changé en base :

* les relations associatedStreet et leur membres,
* les nodes et les ways avec addr:housenumber,
* les highway avec un tag name.

En base de données, des relations associatedStreet "virtuelle" sont créées pour les nodes et ways adresses qui ne font pas déjà parti d'une relation.

* les way avec addr:housenumber sont converti en node au centroïde,
* les addr:housenumber avec code FANTOIR sont regroupés en relation,
* les addr:housenumber avec addr:street et addr:city sont regroupés en relation.

Les polygones englobants de toutes ces relations sont construit.

Les relations associatedStreet sont complétées. Les noms des voies des relations sont retrouvé si besoin parmi les membres. Les addr:city sont remplacés par des codes INSEE à l'aide des polygones de communes.

Les associatedStreet sont enfin converti sous forme de tables relationnelles :voies et numéros. Un polygone englobant est à nouveau calculé.


## Merge

La mise en correspondance consiste à remplir des tables de jointures.

Voies d'OSM avec adresses (associatedStreet d'origines ou virtuelles préalablement construites) - voies du cadastre

### La mise ne correspondance est faite suivant 4 niveaux de confidence :

1. sur le code FANTOIR,
2. sur le code INSEE (même commune) et même nom canonisé,
3. intersection spatiale des polygones englobant et même nom canonisé,
4. intersection spatiale des polygones englobant et nom canonisé à un écart de 1 caractère.

### Voies d'OSM sans adresse - voies du cadastre
Même principe.

1. Intersection spatiale des polygones englobant et même nom canonisé,
2. Intersection spatiale des polygones englobant et nom canonisé à un écart de 1 caractère,
3. Intersection spatiale des polygones englobant et nom canonisé à un écart de 2 caractères,
4. Intersection spatiale des polygones englobant et nom canonisé à un écart de 3 caractères.

### Numéro d'OSM - numéro du cadastre
La mise en correspondance est faite pour les voies déjà mises en correspondances. Recherche des numéros et extension identiques (extension sur 1 caractère).


## Export

L'export consiste produire un fichier pour les voies et un pour les numéros.

La version brute (raw) contiennent les données de toutes les sources. Données sur une même ligne si elles ont pu être mise en correspondance.

La version normale contient un seul exemplaire de chaque voie et de chaque numéro de voie. Si les données ont été mise en correspondance avec OSM ce sont elles qui sont rendues, sinon celles du cadastre.

Sont extraites :

1. Les voies (associatedStreet) avec adresse d'OSM liée ou non à une voie du cadastre,
2. Les voies du cadastre non liée à une voie d'OSM,
3. Les numéros de [voies d'OSM mise en correspondance] avec ou sans correspondance avec des numéros du cadastre,
4. Les numéros de [voies du cadastre mise en correspondance] sans correspondance avec des numéros d'OSM,
4. Les numéros de [voies du cadastre sans correspondance].

### Version brute

Le contenu du fichier street est le suivant :

* osm_type : types d'objets dans OSM, R pour relation, VR pour un des éléments constitutifs de la relation virtuelle (nœud ou way),
* osm_id : identifiants OSM,
* osm_nom : noms dans OSM,
* osm_insee : références INSEE dans OSM, éventuellement traduction du nom de la commune sous forme de référence,
* osm_fantoir : références FANTOIR dans OSM,
* cadastre_nom : noms au cadastre,
* cadastre_insee : références INSEE de la commune au cadastre,
* cadastre_fantoir : références FANTOIR du FANTOIR,
* cadastre_street_id : identifiants internes, non stable,
* match_level : indices de confiance de la mise en correspondance, de 1 (bon) à 4 (moins bon).

La jointure avec le fichier de numéro se fait sur osm_id s'il existe, ou sur le couple cadastre_insee, cadastre_street_id.

Le contenu du fichier number :

* osm_id : identifiant OSM,
* osm_lat : latitude OSM,
* osm_lon : longitude OSM,
* osm_numero : numéro OSM,
* insee : référence INSEE au cadastre (pour jointure),
* cadastre_street_id : identifiants internes, non stable (pour jointure),
* cadastre_lat : latitude au cadastre,
* cadastre_lon : longitude au cadastre,
* cadastre_numero : numéro au cadastre.

### Version normale

Le contenu du fichier street est le suivant :

* id : identifiant interne, non stable,
* nom : noms,
* insee : références INSEE,
* fantoir : références FANTOIR,

La jointure avec le fichier de numéro se fait sur l'id.

Le contenu du fichier number :

* street_id : identifiant interne, non stable,
* lat : latitude,
* lon : longitude,
* numero : numéro,

## Canonisation des noms de voies

En algèbre (dixit Wikipédia) : "il qualifie des formes d'expressions algébriques censément plus simples et en tout cas auxquelles se ramènent toutes les expressions d'un certain type, ce qui permet de les distinguer et de les classifier"
La canonisation lexicale est la même chose, réduction de la forme à quelque chose de plus simple à la qu'elle on peut se ramener.

Le principe ici est de rendre les noms de voies comparables entres les différentes sources. Le parti prit est de remplacer les formes longues de termes par des abréviations, le contraire pouvant être indécidable.

Détail de la canonisation :

* passer en ASCII et en majuscule,
* suppression de la ponctuation,
* retrait des mots muets (de sens) (de, du, le les...),
* passage en abrégés des noms et des voies et de certains mots communs (général, saint...),
* suppression des lettres isolées,
* retrait des ordinaux (ème),
* suppression des espaces inutiles,
* TODO, traitement des nombres romains
