CREATE OR REPLACE FUNCTION indiff(text, text)
RETURNS TEXT
AS $$
     SELECT array_to_string(ARRAY(
         SELECT
             CASE WHEN substring($1 FROM n FOR 1) = substring($2 FROM n FOR 1)
                  THEN ' '
                  ELSE substring($2 FROM n FOR 1)
             END
         FROM generate_series(1, character_length($1)) as n), '');
$$ language sql;
