-- Alter the rental duration and rental rates of the film you inserted before to three weeks and 9.99, respectively.

UPDATE "film" 
SET 
    "rental_duration" = 21, 
    "rental_rate" = 9.99
FROM 
    "film"
WHERE 
    "film"."title" = 'Meg';

/*
Alter any existing customer in the database with at least 10 rental and 10 payment records. 
Change their personal data to yours (first name, last name, address, etc.). 
You can use any existing address from the "address" table. 
Please do not perform any updates on the "address" table, as this can impact multiple records with the same address.
*/

UPDATE "customer"
SET "first_name" = 'Muhammadalixon',
    "last_name" = 'Ergashaliyev',
    "email" = 'muhammadali.ergashaliyev.me@gmail.com',
    "address_id" = addr."address_id"
FROM (
    SELECT "address_id"
    FROM "address"
    WHERE "address" = 'Asaka str. 50'
) AS addr
INNER JOIN (
    SELECT 
        customer.customer_id
    FROM 
        customer
    JOIN 
        rental ON customer.customer_id = rental.customer_id
    JOIN 
        payment ON customer.customer_id = payment.customer_id
    GROUP BY 
        customer.customer_id
    HAVING 
        COUNT(rental.rental_id) >= 10 AND COUNT(payment.payment_id) >= 10
    LIMIT 1
) AS cust ON "customer"."customer_id" = cust.customer_id
WHERE "customer"."customer_id" = cust.customer_id;

-- Change the customer's create_date value to current_date.

UPDATE "customer"
SET "create_date" = CURRENT_DATE;