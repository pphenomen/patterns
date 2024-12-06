ALTER TABLE student ADD CONSTRAINT unique_phone UNIQUE (phone_number);
ALTER TABLE student ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE student ADD CONSTRAINT unique_telegram UNIQUE (telegram);
ALTER TABLE student ADD CONSTRAINT unique_git UNIQUE (git);