CREATE OR REPLACE FUNCTION text_to_bigint_hash (TEXT) 
RETURNS BIGINT AS
 ' 
DECLARE
    result bigint;
    curr char;
    chararray char[];
    counter int;
BEGIN 
    result = 1::bigint<<63;
    chararray = string_to_array($1, NULL)::char[];
    counter = 0;
    FOREACH curr IN ARRAY chararray
    LOOP
        counter := counter + 1;
        result := result + CAST(ASCII(curr) AS BIGINT)^2 * counter;
    END LOOP;

RETURN result;
END; 
' 
LANGUAGE 'plpgsql';
