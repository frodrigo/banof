CREATE TYPE numero AS(
    numero_i INT,
    ext VARCHAR(255)
);

DROP FUNCTION canonisation_numero(str text);
CREATE OR REPLACE FUNCTION canonisation_numero(str text) RETURNS setof numero AS $$
DECLARE
    r numero;
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

    str = replace(str, ' ', '');

    FOR r IN (
        SELECT
            numero_i,
            CASE
                WHEN ext = '' THEN NULL
                ELSE ext
            END AS ext
        FROM (
            SELECT
                cast(substring(regexp_split_to_table from '#"[0-9]+#"%' for '#') as integer) AS numero_i,
                upper(substring(substring(regexp_split_to_table from '[0-9]* *#"%#"' for '#') from 1 for 1)) AS ext
            FROM
                (SELECT regexp_split_to_table(str, E'[-,;]')) AS t
        ) AS t
    ) LOOP
        RETURN NEXT r;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM canonisation_numero('1');
SELECT * FROM canonisation_numero('3bis');
SELECT * FROM canonisation_numero('50-53bis');
SELECT * FROM canonisation_numero('30A-30B');
SELECT * FROM canonisation_numero('31 ; 33');
