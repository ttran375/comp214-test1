# Mid Term – Cursors & Exception Handling

## Question 1 (5 marks)

DECLARE
 lv_mytax_num NUMBER(3,4);
BEGIN
CASE 'ON'
 WHEN 'MN' THEN lv_mytax_num := .08;
 WHEN 'QB' THEN lv_mytax_num := .04;
 WHEN 'SK' THEN lv_mytax_num := .07;
END CASE;
DBMS_OUTPUT.PUT_LINE('tax rate = '||lv_mytax_num);
END;
a. Enter and run the block of code above and save a screen shot of the code and error in the
output.
b. Modify the code by adding an exception handle for the error message, with a custom
message saying, “No tax found for this code block”. Save a screenshot of your modified
code and output.

## Question 2 (5 marks)

The block of code below has been created to retrieve customer information for this application.
The application page was adjusted so that an employee can enter a customer number that could
lead to an error that should be handled.
DECLARE
rec_comp214shop bb_shopper%ROWTYPE;
BEGIN
SELECT *
 INTO rec_comp214shop
 FROM bb_shopper
WHERE idShopper = ??;
END;
a. Enter and run the block of code above and capture error output.
b. Modify the block by adding an exception handler that displays the message “ID for this
user is invalid” onscreen. For this question, use an initialized variable named
lv_compshp_number to provide an ID for the shopper ID.
c. Test the block with the shopper ID 7.

## Question 3 (5 marks)

Once an application has been built, there are times modification will be required, for the DoGood Donor
solution, there is a page which allows administrators of the application to change the ID assigned to each
donor, the information for each doner is saved in the DD_DONOR table.
a. Create a PL/SQL block to handle this task, which includes creating an exception handling code to
contain an error raised by attempting to enter a duplicate doner ID number.
b. If this error occurs, display the message “Duplicate error, this ID is already assigned to a donor,
use a different ID number.” Test the code by attempting to changing donor ID 303 using donor
ID 307.
c. Capture and save your output.
