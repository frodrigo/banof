#!/bin/bash

BANO_CACHE=/data/work/cadastre.openstreetmap.fr/bano_cache
BANOF_CACHE=/data/work/fred/banof
EXTRACTOR=/home/fred/export-cadastre/bin/cadastre-housenumber/cadastre_vers_osm_adresses.py

for CODE_DEP in `cat deps.list`; do
  dep=$BANO_CACHE/$CODE_DEP
  for comm in $dep/*; do
    echo $comm
    CODE_COMM=`basename $comm`
    cd $comm
    mkdir --parents $BANOF_CACHE/$CODE_DEP/$CODE_COMM
    $EXTRACTOR -nd -ne -nzip $CODE_DEP $CODE_COMM $BANOF_CACHE/$CODE_DEP/$CODE_COMM
    cd -
    ruby 20_cadastre-adresses_osm_2_csv.rb $CODE_DEP $BANOF_CACHE/$CODE_DEP/$CODE_COMM/$CODE_COMM-adresses.osm
    ruby 20_cadastre-nom_2_csv.rb $CODE_DEP $BANOF_CACHE/$CODE_DEP/$CODE_COMM/$CODE_COMM-noms.osm
  done
done
