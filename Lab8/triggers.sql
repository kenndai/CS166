CREATE SEQUENCE part_number_seq START WITH 50000;

CREATE LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION auto_part_number()
RETURNS "trigger" AS
$BODY$
    BEGIN
	NEW.part_number := nextval('part_number_seq');
	RETURN NEW;
    END;
$BODY$
LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER insert_record BEFORE INSERT 
ON part_nyc FOR EACH ROW
EXECUTE PROCEDURE auto_part_number();
