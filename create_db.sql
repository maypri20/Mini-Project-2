CREATE DATABASE IF NOT EXISTS nyc_project;


CREATE TABLE `accomodation` (
  `accomodation_id` INT,
  `location` VARCHAR(255),
  `availability` INT,
  `room_type` VARCHAR(255),
  `price` INT,
  PRIMARY KEY (`accomodation_id`)
);

CREATE TABLE `student` (
  `student_id` INT,
  `student_name` VARCHAR(255),
  `accomodation_id` INT,
  `event_id` INT,
  PRIMARY KEY (`student_id`)
);

CREATE TABLE `event` (
  `event_id` INT,
  `name` VARCHAR(255),
  `duration` INT,
  `location` VARCHAR(255),
  PRIMARY KEY (`event_id`)
);

ALTER TABLE `student`
 ADD CONSTRAINT `student_accomodation` FOREIGN KEY `accomodation_id` REFERENCES `accomodation` (`accomodation_id`),
 ADD CONSTRAINT `student_event` FOREIGN KEY `student_id` REFERENCES `student` (`student_id`);
