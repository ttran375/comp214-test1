-- Question 1 (5 marks)
-- DECLARE
--  lv_mytax_num NUMBER(3,4);
-- BEGIN
-- CASE 'ON'
--  WHEN 'MN' THEN lv_mytax_num := .08;
--  WHEN 'QB' THEN lv_mytax_num := .04;
--  WHEN 'SK' THEN lv_mytax_num := .07;
-- END CASE;
-- DBMS_OUTPUT.PUT_LINE('tax rate = '||lv_mytax_num);
-- END;
-- a. Enter and run the block of code above and save a screen shot of the code and error in the
-- output.
-- b. Modify the code by adding an exception handle for the error message, with a custom
-- message saying, “No tax found for this code block”. Save a screenshot of your modified
-- code and output.

-- a. Enter and run the block of code above and save a screen shot of the code and error in the
-- output.
-- SQL> DECLARE
--   2      lv_mytax_num NUMBER(3, 4);
--   3  BEGIN
--   4      CASE 'ON'
--   5          WHEN 'MN' THEN
--   6              lv_mytax_num := .08;
--   7          WHEN 'QB' THEN
--   8              lv_mytax_num := .04;
--   9          WHEN 'SK' THEN
--   10              lv_mytax_num := .07;
--   11      END CASE;
--   12
--   13      DBMS_OUTPUT.PUT_LINE('tax rate = '
--   14                           ||lv_mytax_num);
--   15  END;

-- DECLARE
-- *
-- ERROR at line 1:
-- ORA-06592: CASE not found while executing CASE statement
-- ORA-06512: at line 4

-- b. Modify the code by adding an exception handle for the error message, with a custom
-- message saying, “No tax found for this code block”. Save a screenshot of your modified
-- code and output.
DECLARE
    lv_mytax_num NUMBER(3, 4);
BEGIN
    CASE 'ON'
        WHEN 'MN' THEN
            lv_mytax_num := .08;
        WHEN 'QB' THEN
            lv_mytax_num := .04;
        WHEN 'SK' THEN
            lv_mytax_num := .07;
 -- If the string is none of the above, raise an application error
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'No tax found for this code block');
    END CASE;

    DBMS_OUTPUT.PUT_LINE('tax rate = '
                         ||lv_mytax_num);
 -- If any error occurs, catch it and output the error message
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: '
                             || SQLERRM);
END;
