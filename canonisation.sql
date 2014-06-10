CREATE OR REPLACE FUNCTION canonisation(str text) RETURNS text AS $$
DECLARE
    a text[] := array['DE', 'DU', 'DES', 'LA', 'LE', 'LES', 'ET'];
    i text;
BEGIN
    str = replace(str, 'â', 'a');
    str = replace(str, 'à', 'a');
    str = replace(str, 'ç', 'c');
    str = replace(str, 'è', 'e');
    str = replace(str, 'ê', 'e');
    str = replace(str, 'é', 'e');
    str = replace(str, 'ë', 'e');
    str = replace(str, 'ï', 'i');
    str = replace(str, 'î', 'i');
    str = replace(str, 'ö', 'o');
    str = replace(str, 'ô', 'o');
    str = replace(str, 'û', 'u');
    str = replace(str, 'ü', 'u');

    str = upper(str);

    str = replace(str, 'Â', 'A');
    str = replace(str, 'À', 'A');
    str = replace(str, 'Ç', 'C');
    str = replace(str, 'È', 'E');
    str = replace(str, 'Ê', 'E');
    str = replace(str, 'É', 'E');
    str = replace(str, 'Ë', 'E');
    str = replace(str, 'Ï', 'I');
    str = replace(str, 'Î', 'I');
    str = replace(str, 'Ö', 'O');
    str = replace(str, 'Ô', 'O');
    str = replace(str, 'Û', 'U');
    str = replace(str, 'Ü', 'U');

    str = replace(str, '-', ' ');
    str = replace(str, '''', ' ');
    str = replace(str, '/', ' ');

    str = replace(str, '.', '');

    str = regexp_replace(str, '\(.*\)', '');

    --Trop lent -> on fait en direct dans le code
    --FOR rec IN (SELECT abrev, type_voie FROM abrev_type_voie) LOOP
    --    str = regexp_replace(str, '^(' || rec.type_voie || ') ', rec.abrev || ' ', 'g');
    --END LOOP;

    str = regexp_replace(str, '^ANCIEN CHEMIN ', 'ACH ');
    str = regexp_replace(str, '^AERODROME ', 'AER ');
    str = regexp_replace(str, '^AGGLOMERATION ', 'AGL ');
    str = regexp_replace(str, '^AIRE ', 'AIRE ');
    str = regexp_replace(str, '^ALLEE ', 'ALL ');
    str = regexp_replace(str, '^ANGLE ', 'ANGL ');
    str = regexp_replace(str, '^ARCADE ', 'ARC ');
    str = regexp_replace(str, '^ANCIENNE ROUTE ', 'ART ');
    str = regexp_replace(str, '^AUTOROUTE ', 'AUT ');
    str = regexp_replace(str, '^AVENUE ', 'AV ');
    --str = regexp_replace(str, '^BASE ', 'BASE ');
    str = regexp_replace(str, '^BOULEVARD ', 'BD ');
    str = regexp_replace(str, '^BERGE ', 'BER ');
    --str = regexp_replace(str, '^BORD ', 'BORD ');
    str = regexp_replace(str, '^BARRIERE ', 'BRE ');
    str = regexp_replace(str, '^BOURG ', 'BRG ');
    str = regexp_replace(str, '^BRETELLE ', 'BRTL ');
    str = regexp_replace(str, '^BASSIN ', 'BSN ');
    str = regexp_replace(str, '^CARRIERA ', 'CAE ');
    str = regexp_replace(str, '^CALLE ', 'CALL ');
    str = regexp_replace(str, '^CAMIN ', 'CAMI ');
    --str = regexp_replace(str, '^CAMP ', 'CAMP ');
    str = regexp_replace(str, '^CANAL ', 'CAN ');
    str = regexp_replace(str, '^CARREFOUR ', 'CAR ');
    str = regexp_replace(str, '^CARRIERE ', 'CARE ');
    str = regexp_replace(str, '^CASERNE ', 'CASR ');
    str = regexp_replace(str, '^CHEMIN COMMUNAL ', 'CC ');
    str = regexp_replace(str, '^CHEMIN DEPARTEMENTAL ', 'CD ');
    str = regexp_replace(str, '^CHEMIN FORESTIER ', 'CF ');
    str = regexp_replace(str, '^CHASSE ', 'CHA ');
    str = regexp_replace(str, '^CHEM ', 'CHE ');
    str = regexp_replace(str, '^CHEMIN ', 'CHE ');
    str = regexp_replace(str, '^CHEMINEMENT ', 'CHE ');
    str = regexp_replace(str, '^CHALET ', 'CHL ');
    str = regexp_replace(str, '^CHAMP ', 'CHP ');
    str = regexp_replace(str, '^CHAUSSEE ', 'CHS ');
    str = regexp_replace(str, '^CHATEAU ', 'CHT ');
    str = regexp_replace(str, '^CHEMIN VICINAL ', 'CHV ');
    --str = regexp_replace(str, '^CITE ', 'CITE ');
    str = regexp_replace(str, '^COURSIVE ', 'CIVE ');
    --str = regexp_replace(str, '^CLOS ', 'CLOS ');
    str = regexp_replace(str, '^COULOIR ', 'CLR ');
    --str = regexp_replace(str, '^COIN ', 'COIN ');
    --str = regexp_replace(str, '^COL ', 'COL ');
    str = regexp_replace(str, '^CORNICHE ', 'COR ');
    str = regexp_replace(str, '^CORON ', 'CORO ');
    --str = regexp_replace(str, '^COTE ', 'COTE ');
    --str = regexp_replace(str, '^COUR ', 'COUR ');
    str = regexp_replace(str, '^CAMPING ', 'CPG ');
    str = regexp_replace(str, '^CHEMIN RURAL ', 'CR ');
    str = regexp_replace(str, '^COURS ', 'CRS ');
    str = regexp_replace(str, '^CROIX ', 'CRX ');
    str = regexp_replace(str, '^CONTOUR ', 'CTR ');
    str = regexp_replace(str, '^CENTRE ', 'CTRE ');
    str = regexp_replace(str, '^DARSE ', 'DARS ');
    str = regexp_replace(str, '^DEVIATION ', 'DEVI ');
    str = regexp_replace(str, '^DIGUE ', 'DIG ');
    str = regexp_replace(str, '^DOMAINE ', 'DOM ');
    str = regexp_replace(str, '^DRAILLE ', 'DRA ');
    str = regexp_replace(str, '^DESCENTE ', 'DSC ');
    str = regexp_replace(str, '^ÉCART ', 'ECA ');
    str = regexp_replace(str, '^ECLUSE ', 'ECL ');
    str = regexp_replace(str, '^EMBRANCHEMENT ', 'EMBR ');
    str = regexp_replace(str, '^ENCLOS ', 'ENC ');
    str = regexp_replace(str, '^ENCLAVE ', 'ENV ');
    str = regexp_replace(str, '^ESCALIER ', 'ESC ');
    str = regexp_replace(str, '^ESPLANADE ', 'ESP ');
    str = regexp_replace(str, '^ESPACE ', 'ESPA ');
    str = regexp_replace(str, '^ETANG ', 'ETNG ');
    str = regexp_replace(str, '^FOND ', 'FD ');
    str = regexp_replace(str, '^FAUBOURG ', 'FG ');
    str = regexp_replace(str, '^FONTAINE ', 'FON ');
    --str = regexp_replace(str, '^FORT ', 'FORT ');
    str = regexp_replace(str, '^FOSSE ', 'FOS ');
    str = regexp_replace(str, '^FERME ', 'FRM ');
    str = regexp_replace(str, '^GALERIE ', 'GAL ');
    --str = regexp_replace(str, '^GARE ', 'GARE ');
    str = regexp_replace(str, '^GRAND BOULEVARD ', 'GBD ');
    str = regexp_replace(str, '^GRAND PLACE ', 'GPL ');
    str = regexp_replace(str, '^GR GRANDE RUE ', 'GR ');
    str = regexp_replace(str, '^GRANDE RUE ', 'GR ');
    str = regexp_replace(str, '^HABITATION ', 'HAB ');
    str = regexp_replace(str, '^HAMEAU ', 'HAM ');
    str = regexp_replace(str, '^HALLE ', 'HLE ');
    str = regexp_replace(str, '^HALAGE ', 'HLG ');
    str = regexp_replace(str, '^HLM ', 'HLM ');
    str = regexp_replace(str, '^ÎLE ', 'ILE ');
    --str = regexp_replace(str, '^ILOT ', 'ILOT ');
    str = regexp_replace(str, '^IMPASSE ', 'IMP ');
    str = regexp_replace(str, '^JARDIN ', 'JARD ');
    str = regexp_replace(str, '^JETEE ', 'JTE ');
    --str = regexp_replace(str, '^LAC ', 'LAC ');
    str = regexp_replace(str, '^LEVEE ', 'LEVE ');
    str = regexp_replace(str, '^LICES ', 'LICE ');
    str = regexp_replace(str, '^LIGNE ', 'LIGN ');
    str = regexp_replace(str, '^LOTISSEMENT ', 'LOT ');
    --str = regexp_replace(str, '^MAIL ', 'MAIL ');
    str = regexp_replace(str, '^MAISON ', 'MAIS ');
    str = regexp_replace(str, '^MARCHE ', 'MAR ');
    str = regexp_replace(str, '^MAS ', 'MAS ');
    str = regexp_replace(str, '^MARINA ', 'MRN ');
    str = regexp_replace(str, '^MONTEE ', 'MTE ');
    str = regexp_replace(str, '^NOUVELLE ROUTE ', 'NTE ');
    str = regexp_replace(str, '^PETITE AVENUE ', 'PAE ');
    --str = regexp_replace(str, '^PARC ', 'PARC ');
    str = regexp_replace(str, '^PASSAGE ', 'PAS ');
    str = regexp_replace(str, '^PASSE ', 'PASS ');
    str = regexp_replace(str, '^PCH PETIT CHEMIN ', 'PCH ');
    str = regexp_replace(str, '^PETIT CHEMIN ', 'PCH ');
    str = regexp_replace(str, '^PHARE ', 'PHAR ');
    str = regexp_replace(str, '^PISTE ', 'PIST ');
    str = regexp_replace(str, '^PARKING ', 'PKG ');
    str = regexp_replace(str, '^PLACE ', 'PL ');
    str = regexp_replace(str, '^PLACA ', 'PLA ');
    str = regexp_replace(str, '^PLAGE ', 'PLAG ');
    str = regexp_replace(str, '^PLAN ', 'PLAN ');
    str = regexp_replace(str, '^PLACIS ', 'PLCI ');
    str = regexp_replace(str, '^PASSERELLE ', 'PLE ');
    str = regexp_replace(str, '^PLAINE ', 'PLN ');
    str = regexp_replace(str, '^PLATEAU ', 'PLT ');
    str = regexp_replace(str, '^POINTE ', 'PNT ');
    --str = regexp_replace(str, '^PONT ', 'PONT ');
    str = regexp_replace(str, '^PORTIQUE ', 'PORQ ');
    --str = regexp_replace(str, '^PORT ', 'PORT ');
    str = regexp_replace(str, '^POSTE ', 'POST ');
    str = regexp_replace(str, '^POTERNE ', 'POT ');
    str = regexp_replace(str, '^PROMENADE ', 'PROM ');
    str = regexp_replace(str, '^PETITE ROUTE ', 'PRT ');
    str = regexp_replace(str, '^PARVIS ', 'PRV ');
    str = regexp_replace(str, '^PETITE ALLEE ', 'PTA ');
    str = regexp_replace(str, '^PORTE ', 'PTE ');
    str = regexp_replace(str, '^PETITE RUE ', 'PTR ');
    str = regexp_replace(str, '^PTR PETITE RUE ', 'PTR ');
    str = regexp_replace(str, '^PLACETTE ', 'PTTE ');
    str = regexp_replace(str, '^QUARTIER ', 'QUA ');
    --str = regexp_replace(str, '^QUAI ', 'QUAI ');
    str = regexp_replace(str, '^RACCOURCI ', 'RAC ');
    str = regexp_replace(str, '^REMPART ', 'REM ');
    str = regexp_replace(str, '^RESIDENCE ', 'RES ');
    --str = regexp_replace(str, '^RIVE ', 'RIVE ');
    str = regexp_replace(str, '^RUELLE ', 'RLE ');
    str = regexp_replace(str, '^ROCADE ', 'ROC ');
    str = regexp_replace(str, '^RAMPE ', 'RPE ');
    str = regexp_replace(str, '^ROND POINT ', 'RPT ');
    str = regexp_replace(str, '^ROTONDE ', 'RTD ');
    str = regexp_replace(str, '^ROUTE ', 'RTE ');
    --str = regexp_replace(str, '^RUE ', 'RUE ');
    str = regexp_replace(str, '^RUETTE ', 'RUET ');
    str = regexp_replace(str, '^RUISSEAU ', 'RUIS ');
    str = regexp_replace(str, '^RUELLETTE ', 'RULT ');
    str = regexp_replace(str, '^RAVINE ', 'RVE ');
    --str = regexp_replace(str, '^SAS ', 'SAS ');
    str = regexp_replace(str, '^SENTIER ', 'SEN ');
    str = regexp_replace(str, '^SQUARE ', 'SQ ');
    str = regexp_replace(str, '^STADE ', 'STDE ');
    --str = regexp_replace(str, '^TOUR ', 'TOUR ');
    str = regexp_replace(str, '^TERRE PLEIN ', 'TPL ');
    str = regexp_replace(str, '^TRAVERSE ', 'TRA ');
    str = regexp_replace(str, '^TRABOULE ', 'TRAB ');
    str = regexp_replace(str, '^TERRAIN ', 'TRN ');
    str = regexp_replace(str, '^TERTRE ', 'TRT ');
    str = regexp_replace(str, '^TERRASSE ', 'TSSE ');
    str = regexp_replace(str, '^TUNNEL ', 'TUN ');
    --str = regexp_replace(str, '^VAL ', 'VAL ');
    str = regexp_replace(str, '^VALLON ', 'VALL ');
    str = regexp_replace(str, '^VOIE COMMUNALE ', 'VC ');
    str = regexp_replace(str, '^VIEUX CHEMIN ', 'VCHE ');
    str = regexp_replace(str, '^VENELLE ', 'VEN ');
    str = regexp_replace(str, '^VILLAGE ', 'VGE ');
    --str = regexp_replace(str, '^VIA ', 'VIA ');
    str = regexp_replace(str, '^VIADUC ', 'VIAD ');
    str = regexp_replace(str, '^VILLE ', 'VIL ');
    str = regexp_replace(str, '^VILLA ', 'VLA ');
    str = regexp_replace(str, '^VOIE ', 'VOIE ');
    str = regexp_replace(str, '^VOIRIE ', 'VOIR ');
    str = regexp_replace(str, '^VOUTE ', 'VOUT ');
    str = regexp_replace(str, '^VOYEUL ', 'VOY ');
    str = regexp_replace(str, '^VIEILLE ROUTE ', 'VTE ');
    --str = regexp_replace(str, '^ZA ', 'ZA ');
    --str = regexp_replace(str, '^ZAC ', 'ZAC ');
    --str = regexp_replace(str, '^ZAD ', 'ZAD ');
    --str = regexp_replace(str, '^ZI ', 'ZI ');
    --str = regexp_replace(str, '^ZONE ', 'ZONE ');
    --str = regexp_replace(str, '^ZUP ', 'ZUP ');

    str = regexp_replace(str, '(^| )MARECHAL( |$)', ' MAL ', 'g');
    str = regexp_replace(str, '(^| )PRESIDENT( |$)', ' PDT ', 'g');
    str = regexp_replace(str, '(^| )GENERAL( |$)', ' GEN ', 'g');
    str = regexp_replace(str, '(^| )GAL( |$)', ' GEN ', 'g');
    str = regexp_replace(str, '(^| )COMMANDANT( |$)', ' CDT ', 'g');
    str = regexp_replace(str, '(^| )CAPITAINE( |$)', ' CAP ', 'g');
    str = regexp_replace(str, '(^| )REGIMENT( |$)', ' REGT ', 'g');
    str = regexp_replace(str, '(^| )SAINTE( |$)', ' STE ', 'g');
    str = regexp_replace(str, '(^| )SAINT( |$)', ' ST ', 'g');
    str = regexp_replace(str, '(^| )DOCTEUR( |$)', ' DOC ', 'g');
    str = regexp_replace(str, '(^| )REGIMENT( |$)', ' REGT ', 'g');
    str = regexp_replace(str, '(^| )ENFANTS( |$)', ' ENFTS ', 'g');
    str = regexp_replace(str, '(^| )ANCIENS?( |$)', ' ANC ', 'g');
    str = regexp_replace(str, '(^| )ANCIENNES?( |$)', ' ANC ', 'g');
    str = regexp_replace(str, '(^| )NEUVE( |$)', ' NVE ', 'g');




    str = regexp_replace(str, '(^| )ZERO( |$)', ' 0 ', 'g');

    str = regexp_replace(str, '(^| )UN( |$)', ' [1] ', 'g');
    str = regexp_replace(str, '(^| )DEUX( |$)', ' [2] ', 'g');
    str = regexp_replace(str, '(^| )TROIS( |$)', ' [3] ', 'g');
    str = regexp_replace(str, '(^| )QUATRE( |$)', ' [4] ', 'g');
    str = regexp_replace(str, '(^| )CINQ( |$)', ' [5] ', 'g');
    str = regexp_replace(str, '(^| )SIX( |$)', ' [6] ', 'g');
    str = regexp_replace(str, '(^| )SEPT( |$)', ' [7] ', 'g');
    str = regexp_replace(str, '(^| )HUIT( |$)', ' [8] ', 'g');
    str = regexp_replace(str, '(^| )NEUF( |$)', ' [9] ', 'g');
    str = regexp_replace(str, '(^| )DIX( |$)', ' [10] ', 'g');
    str = regexp_replace(str, '(^| )ONZE( |$)', ' [11] ', 'g');
    str = regexp_replace(str, '(^| )DOUZE( |$)', ' [12] ', 'g');
    str = regexp_replace(str, '(^| )TREIZE( |$)', ' [13] ', 'g');
    str = regexp_replace(str, '(^| )QUATORZE( |$)', ' [14] ', 'g');
    str = regexp_replace(str, '(^| )QUINZE( |$)', ' [15] ', 'g');
    str = regexp_replace(str, '(^| )SEIZE( |$)', ' [16] ', 'g');
    str = regexp_replace(str, '(^| )VINGT( |$)', ' [20] ', 'g');
    str = regexp_replace(str, '(^| )TRENTE( |$)', ' [30] ', 'g');
    str = regexp_replace(str, '(^| )QUARANTE( |$)', ' [40] ', 'g');
    str = regexp_replace(str, '(^| )CINQUANTE( |$)', ' [50] ', 'g');
    str = regexp_replace(str, '(^| )SOIXANTE( |$)', ' [60] ', 'g');
    str = regexp_replace(str, '(^| )CENT( |$)', ' [100] ', 'g');
    str = regexp_replace(str, '(^| )MILLE( |$)', ' [1000] ', 'g');


    str = regexp_replace(str, '^GR GRANDE RUE', 'GR');
    str = regexp_replace(str, '^GRANDE RUE', 'GR');
    str = regexp_replace(str, '^GR GDE RUE', 'GR');
    str = regexp_replace(str, '^VC DITE ', '');
    str = regexp_replace(str, ' RURAL DIT ', '');
    str = regexp_replace(str, ' ZAC$', '');

    str = regexp_replace(str, '(^| )1 ?ER( |$)', ' 1 ');
    str = regexp_replace(str, '(^| )([1-9]+) ?EME( |$)', '\1 \2 \3');

    FOREACH i IN ARRAY a
    LOOP
        str = regexp_replace(str, ' ' || i || ' ', ' ', 'g');
    END LOOP;
    str = regexp_replace(str, '(^| )[A-Z]( |$)', ' ', 'g');

    -- TODO ROMAIN

    -- nombres
    str = regexp_replace(str, '([0-9])\] \[', '\1][', 'g');
    str = regexp_replace(str, '\[1000\]', ' [1000] ', 'g');

    str = regexp_replace(str, '\[60\]\[1([0-9])\]', '[7\1]', 'g'); -- 70
    str = regexp_replace(str, '\[4\]\[20\]\[1([0-9])\]', '[9\1]', 'g'); -- 90
    str = regexp_replace(str, '\[4\]\[20\]', '[80]', 'g'); -- 80

    str = regexp_replace(str, '\[([0-9])\]\[100\]', '[\100]', 'g'); -- unité + centaines


    str = regexp_replace(str, '\[([0-9]+)0\]\[([1-9])\]', '[\1\2]', 'g'); -- dixaine + unité
    str = regexp_replace(str, '\[([0-9]+)00\]\[([1-9])\]', '[\10\2]', 'g'); -- centaine + unité

    str = regexp_replace(str, '\[([0-9]+)00\]\[([1-9][0-9])\]', '[\1\2]', 'g'); -- centaine + dixaine-unité

    str = regexp_replace(str, '\[([0-9]+)\] \[1000\]', '[\1000]', 'g'); -- centaines de millies

    str = regexp_replace(str, '\[([0-9]+)000\] \[([1-9])\]', '[\100\2]', 'g'); -- millier + centaines
    str = regexp_replace(str, '\[([0-9]+)000\] \[([1-9][0-9])\]', '[\10\2]', 'g');
    str = regexp_replace(str, '\[([0-9]+)000\] \[([1-9][0-9][0-9])\]', '[\1\2]', 'g');

    str = regexp_replace(str, '\[([0-9]+)\]', '\1', 'g');

    -- espaces
    str = regexp_replace(str, '  +', ' ');
    str = regexp_replace(str, '^ ', '');
    str = regexp_replace(str, ' $', '');

    RETURN str;
END;
$$ LANGUAGE plpgsql;

--SELECT canonisation(' aa ') = 'AA' AND canonisation(' aéa ') = 'AEA';
--SELECT canonisation(' AA ') = 'AA' AND canonisation(' AA  AA ') = 'AA AA' AND canonisation(' AA DE BB') = 'AA BB';
--SELECT canonisation(' AA DE') = 'AA DE';
--SELECT canonisation('LE AA') = 'LE AA';
--SELECT canonisation('Z EE R TT G') = 'EE TT';
--SELECT canonisation('ALLEE BAS') = 'ALL BAS';
--SELECT canonisation('AV MARECHAL WWW') = 'AV MAL WWW' AND canonisation('MARECHAL WWW') = 'MAL WWW' AND canonisation('RUE MARECHAL') = 'RUE MAL';
--SELECT canonisation('RUE DU 1 ER MAI') = 'RUE 1 MAI';
--SELECT canonisation('2EME INFANT') = '2 INFANT';
--SELECT canonisation('BIBOBU (TITI)') = 'BIBOBU';

--SELECT canonisation('UN') = '1';
--SELECT canonisation('DIX') = '10';
--SELECT canonisation('ONZE') = '11';
--SELECT canonisation('dix-huit') = '18';
--SELECT canonisation('TRENTE SIX') = '36';
--SELECT canonisation('SOIXANTE TREIZE') = '73';
--SELECT canonisation('quatre-vingt-deux') = '82';
--SELECT canonisation('quatre-vingt-dix-neuf') = '99';
--SELECT canonisation('cent un') = '101';
--SELECT canonisation('cent quarante-quatre')= '144';
--SELECT canonisation('trois cent trois') = '303';
--SELECT canonisation('mille dix') = '1010';
--SELECT canonisation('mille sept cent') = '1700';
--SELECT canonisation('mille sept cent vingt-huit') = '1728';
--SELECT canonisation('deux mille un') = '2001';
--SELECT canonisation('dix mille') = '10000';
--SELECT canonisation('vingt et un mille') = '21000';
--SELECT canonisation('quinze mille dix') = '15010';
--SELECT canonisation('cent quatre vingt quatorze mille cinq cent douze') = '194512';
