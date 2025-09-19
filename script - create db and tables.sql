CREATE DATABASE MiniProject2;

USE MiniProject2;

#BEFORE RUNNING THE NEXT LINE IMPORT CSV FILE OF THE NY DATA AND CREATE THE TABLE WITH THIS NAME (ny_df).

#INCLUDE ID COLUMN ON ny_df
ALTER TABLE `ny_df`
	ADD COLUMN `accomodation_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

CREATE TABLE `event`(
    `event_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `event_duration` INT NOT NULL,
    `event_location` VARCHAR(255) NOT NULL
);
CREATE TABLE `students`(
    `student_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `student_name` VARCHAR(255) NOT NULL,
    `accomodation_id` INT,
    `event_id` INT
);

#MAKES THE VALUES IN EACH LINE MANDATORILY UNIQUE IN THE COLUMN `accomodation_id`
ALTER TABLE
    `students` ADD UNIQUE `students_accomodation_id_unique`(`accomodation_id`);

#MAKES THE VALUES IN EACH LINE MANDATORILY UNIQUE IN THE COLUMN `event_id`
ALTER TABLE
    `students` ADD UNIQUE `students_event_id_unique`(`event_id`);

#ESTABLISHES FOREIGN KEYS
ALTER TABLE
    `students` ADD CONSTRAINT `students_accomodation_id_foreign` FOREIGN KEY(`accomodation_id`) REFERENCES `ny_df`(`accomodation_id`);
ALTER TABLE
    `students` ADD CONSTRAINT `students_event_id_foreign` FOREIGN KEY(`event_id`) REFERENCES `event`(`event_id`);