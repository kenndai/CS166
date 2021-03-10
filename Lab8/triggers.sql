:CREATE SEQUENCE part_number_seq START WITH 50000;
--nextval(name), currval(name), setval(name)


--your task is to implement a trigger and procedure to automatically populate part number with
--incremented value upon insertion of the new row into part nyc. After that your insert statements
--should not include value for part number.

-- Create a procedure that will return next value of the aforementioned sequence. Use function
-- nextval(part_number_seq) to get the next value from the sequence.
CREATE LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION auto_part_number() RETURNS "trigger" AS $insert_record$
    BEGIN
        RETURN nextval(part_number_seq);
    END;
LANGUAGE plpgsql VOLATILE;

--create a trigger calling the procedure upon insertion of a new record
CREATE TRIGGER insert_record
AFTER INSERT ON part_nyc
    FOR EACH STATEMENT EXECUTE PROCEDURE auto_part_num();
