-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Represent customers making the purchase
CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone" INTEGER NOT NULL UNIQUE,
    "email" INTEGER NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represent transactions made by the customers
CREATE TABLE "transactions" (
    "id" INTEGER,
    "date" DATE NOT NULL,
    "item_id" INTEGER,
    "shop_id" INTEGER,
    "customer_id" INTEGER,
    "advisor_id" INTEGER,
    "payment_id" INTEGER,
    "survey_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("item_id") REFERENCES "item"("id"),
    FOREIGN KEY("shop_id") REFERENCES "shop"("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id"),
    FOREIGN KEY("advisor_id") REFERENCES "advisor"("id"),
    FOREIGN KEY("payment_id") REFERENCES "payment"("id"),
    FOREIGN KEY("survey_id") REFERENCES "survey"("id")
);

-- Represent survey submitted by customer
CREATE TABLE "survey" (
    "id" INTEGER,
    "date" DATE NOT NULL,
    "rating" INTEGER NOT NULL CHECK("rating" BETWEEN 0 AND 10),
    "comment" TEXT,
    "transaction_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("transaction_id") REFERENCES "transactions"("id")
);

-- Represent where transactions are made
CREATE TABLE "shop" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent item that transactions included
CREATE TABLE "item" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "price" NUMERIC NOT NULL,
    "category" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent payment that transactions are paid
CREATE TABLE "payment" (
    "id" INTEGER,
    "type" TEXT NOT NULL,
    "amount" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

-- Represent manager who write logs
CREATE TABLE "manager" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "advisor_id" INTEGER,
    "shop_id" INTEGER,
    "log_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("advisor_id") REFERENCES "advisor"("id"),
    FOREIGN KEY("shop_id") REFERENCES "shop"("id"),
    FOREIGN KEY("log_id") REFERENCES "log"("id")
);

-- Represent advisor who write logs
CREATE TABLE "advisor" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "shop_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("shop_id") REFERENCES "shop"("id")
);

-- Represent log written by manager
CREATE TABLE "log" (
    "id" INTEGER,
    "date" DATE,
    "response" TEXT,
    "followup_status" TEXT,
    PRIMARY KEY("id")
);



-- Create indexes to speed common searches
CREATE INDEX "log_followup_search" ON "log" ("followup_status");
CREATE INDEX "advisor_search" ON "advisor" ("name");
CREATE INDEX "rating_search" ON "survey" ("rating");
