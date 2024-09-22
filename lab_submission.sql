-- CREATE TRG_AFTER_UPDATE_ON_customers

CREATE TRIGGER TRG_AFTER_UPDATE_ON_customers
AFTER UPDATE ON customers
FOR EACH ROW
BEGIN

    DELETE FROM customers_data_reminders
    WHERE customerNumber = OLD.customerNumber;

    -- 2. Insert reminders to fill in missing data for the updated customer
    -- Example: Check for missing phone, addressLine1, or other important details
    IF NEW.phone IS NULL THEN
        INSERT INTO customers_data_reminders (customerNumber, reminderMessage)
        VALUES (NEW.customerNumber, 'Please provide a phone number.');
    END IF;

    IF NEW.addressLine1 IS NULL THEN
        INSERT INTO customers_data_reminders (customerNumber, reminderMessage)
        VALUES (NEW.customerNumber, 'Please provide a street address.');
    END IF;

    IF NEW.city IS NULL THEN
        INSERT INTO customers_data_reminders (customerNumber, reminderMessage)
        VALUES (NEW.customerNumber, 'Please provide a city name.');
    END IF;

    IF NEW.country IS NULL THEN
        INSERT INTO customers_data_reminders (customerNumber, reminderMessage)
        VALUES (NEW.customerNumber, 'Please provide a country.');
    END IF;
END;

-- UPDATE part
-- Step 1: Drop the existing check constraint if it exists
-- (Replace `chk_part_price` with the actual constraint name if it's different)
ALTER TABLE part
DROP CONSTRAINT IF EXISTS chk_part_price;

-- Step 2: Add the new check constraint
ALTER TABLE part
ADD CONSTRAINT chk_part_price
CHECK (part_selling_price > part_-- Step 1: Drop the existing check constraint if it exists
-- (Replace `chk_part_price` with the actual constraint name if it's different)
ALTER TABLE part
DROP CONSTRAINT IF EXISTS chk_part_price;

-- Step 2: Add the new check constraint
ALTER TABLE part
ADD CONSTRAINT chk_part_price
CHECK (part_selling_price > part_buying_price);
);
