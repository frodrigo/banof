UPDATE
    cadastre_number
SET
    numero_i = cast(substring(numero from '#"[0-9]+#"%' for '#') as integer),
    ext = upper(substring(substring(numero from '[0-9]* *#"%#"' for '#') from 1 for 1))
;

UPDATE
    cadastre_number
SET
    ext = NULL
WHERE
    ext = ''
;
