--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------
-- a. Enter and run the block of code above and save a screen shot of the code and error in the
-- output.
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
    END CASE;

    DBMS_OUTPUT.PUT_LINE('tax rate = '
                         ||lv_mytax_num);
END;
/
-- DECLARE
-- *
-- ERROR at line 1:
-- ORA-06592: CASE not found while executing CASE statement
-- ORA-06512: at line 4
--------------------------------------------------------------------------------------
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
/

-- An error occurred: ORA-20001: No tax found for this code block

-- PL/SQL procedure successfully completed.

-- Commit complete.
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
-- Question 2 (5 marks)
-- The block of code below has been created to retrieve customer information for this application.
-- The application page was adjusted so that an employee can enter a customer number that could
-- lead to an error that should be handled.
-- DECLARE
-- rec_comp214shop bb_shopper%ROWTYPE;
-- BEGIN
-- SELECT *
--  INTO rec_comp214shop
--  FROM bb_shopper
-- WHERE idShopper = ??;
-- END;
--------------------------------------------------------------------------------------
-- a. Enter and run the block of code above and capture error output.
DECLARE
    rec_comp214shop bb_shopper%ROWTYPE;
BEGIN
    SELECT
        * INTO rec_comp214shop
    FROM
        bb_shopper
    WHERE
        idShopper = ??;
END;
/
--         idShopper = ??;
--                      *
-- ERROR at line 9:
-- ORA-06550: line 9, column 21:
-- PL/SQL: ORA-00911: invalid character
-- ORA-06550: line 4, column 5:
-- PL/SQL: SQL Statement ignored
--------------------------------------------------------------------------------------
-- b. Modify the block by adding an exception handler that displays the message “ID for this
-- user is invalid” onscreen. For this question, use an initialized variable named
-- lv_compshp_number to provide an ID for the shopper ID.
-- c. Test the block with the shopper ID 7.
DECLARE
    rec_comp214shop   bb_shopper%ROWTYPE;
    -- Declare and initialize a variable to hold the shopper ID
    lv_compshp_number NUMBER := 7;
BEGIN
    SELECT
        * INTO rec_comp214shop
    FROM
        bb_shopper
    WHERE
        idShopper = lv_compshp_number;
EXCEPTION
    -- If there is no row in bb_shopper where idShopper equals lv_compshp_number
    WHEN NO_DATA_FOUND THEN
        -- Output an error message
        DBMS_OUTPUT.PUT_LINE('ID for this user is invalid');
    -- If any other error occurs, catch it and output the error message
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: '
                             || SQLERRM);
END;
/
-- ID for this user is invalid

-- PL/SQL procedure successfully completed.

-- Commit complete.
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
-- Question 3 (5 marks)
-- Once an application has been built, there are times modification will be required, for the DoGood Donor
-- solution, there is a page which allows administrators of the application to change the ID assigned to each
-- donor, the information for each doner is saved in the DD_DONOR table.
--------------------------------------------------------------------------------------
-- a. Create a PL/SQL block to handle this task, which includes creating an exception handling code to
-- contain an error raised by attempting to enter a duplicate doner ID number.
-- b. If this error occurs, display the message “Duplicate error, this ID is already assigned to a donor,
-- use a different ID number.” Test the code by attempting to changing donor ID 303 using donor
-- ID 307.
-- c. Capture and save your output.
DECLARE
    -- Variable to store the count of existing new IDs
    lv_count       INTEGER;
    lv_old_idDonor dd_donor.idDonor%TYPE := 303;
    lv_new_idDonor dd_donor.idDonor%TYPE := 307;
BEGIN
    -- Check if the new ID already exists
    SELECT
        COUNT(*) INTO lv_count
    FROM
        dd_donor
    WHERE
        idDonor = lv_new_idDonor;
    IF lv_count > 0 THEN
        -- New ID already exists, raise an exception
        RAISE_APPLICATION_ERROR(-20001, 'Duplicate error, this ID is already assigned to a donor, use a different ID number.');
    ELSE
        -- Update the donor ID
        UPDATE dd_donor
        SET
            idDonor = lv_new_idDonor
        WHERE
            idDonor = lv_old_idDonor;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Donor ID updated successfully.');
    END IF;
EXCEPTION
    -- This block will catch any exceptions not explicitly handled above
    WHEN OTHERS THEN
        -- If an exception is caught, roll back any changes made in this transaction
        ROLLBACK;
        -- Output the error message to the console
        DBMS_OUTPUT.PUT_LINE('Error: '
                             || SQLERRM);
END;
/
-- Error: ORA-20001: Duplicate error, this ID is already assigned to a donor, use a
-- different ID number.

-- PL/SQL procedure successfully completed.

-- Commit complete.
