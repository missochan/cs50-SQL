-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Find all logs given manager id
SELECT *
FROM "log"
WHERE "id" IN (
    SELECT "log_id"
    FROM "manager"
    WHERE "name" = 'Ben L.'
    AND followup_status = 'No'
);


-- Find transaction details about the survey
SELECT s.name as "Shop", c.id as CustomerID, a.name as 'Advisor', i.name as 'Product name', i.price as 'Product Price', i.category as 'Product Category',
t.date as 'Date' , su.rating as 'Rating', su.comment as 'Comment'
FROM transactions t
LEFT JOIN shop s on s.id=t.shop_id
LEFT JOIN advisor a on a.id = t.advisor_id
LEFT JOIN item i on i.id=t.item_id
LEFT JOIN survey su on su.id= t.survey_id
LEFT JOIN customers c on c.id=t.customer_id
WHERE a.name = "Charles L.";

-- Find average shop rating from the survey
SELECT s.name as 'Shop Name', AVG(su.rating) as "Average Rating"
FROM transactions t
LEFT JOIN shop s on s.id=t.shop_id
LEFT JOIN survey su on su.id=t.survey_id
GROUP BY s.id
ORDER BY "Average Rating";


-- Add a customer
INSERT INTO "customers" ("id", "first_name", "last_name", "phone","email")
VALUES
('11115', 'Edith', 'Cheung', '64321321', 'edith@gmail.com'),

-- Add a Log
INSERT INTO "log" ("id", "date", "response", "followup_status")
VALUES
('5', '10-01-2023', '', 'Yes');

-- Add an item
INSERT INTO "item" ("id", "name", "price", "category")
VALUES
('94444', 'Black dot dress(S)', '200', 'Ready To Wear');

-- Add a payment
INSERT INTO "payment" ("id", "type", "amount")
VALUES
('5', 'Cash', '200');

-- Add a shop
INSERT INTO "shop" ("id", "name", "location")
VALUES
('50', 'N2 Tsim Sha Tsui', 'Hong Kong');

-- Add a survey
INSERT INTO "survey" ("id", "date", "rating", "comment")
VALUES
('5', '06-01-2023', '6', 'Disappointed');

-- Add an Advisor
INSERT INTO "advisor" ("id", "name", "title", "shop_id")
VALUES
('84444', 'Ernest W.', 'Senior Client Advisor', '10');

-- Add a manager
INSERT INTO "Manager" ("id", "name", "title", "advisor_id", "shop_id", "log_id")
VALUES
('89999', 'Ella T.', 'Senior Manager', '84444', '10', '5');


-- Add a transaction
INSERT INTO "transactions" ("id", "date", "item_id", "shop_id","customer_id", "advisor_id", "payment_id", "survey_id")
VALUES
('5', '05-01-2023', '94444', '410', '11115', '84444', '5', '5');
