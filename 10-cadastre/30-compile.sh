find data/ -name *-adresses-number.csv | xargs cat | bzip2 -- > data/adresses-number.csv.bz2
find data/ -name *-adresses-street.csv | xargs cat | bzip2 -- > data/adresses-street.csv.bz2
find data/ -name *-noms.csv | xargs cat | bzip2 -- > data/noms.csv.bz2
