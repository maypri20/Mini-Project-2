USE miniproject2;

SELECT *
FROM event;

SELECT *
FROM ny_df;

SELECT *
FROM students;

CREATE VIEW temp_students_events AS
SELECT 
    students.student_id,
    students.student_name,
    students.accomodation_id AS students_accomodation_id,
    students.event_id AS students_event_id,
    event.event_id AS event_id,
    event.name AS event_name, 
    event.event_duration AS event_duration,
    event.event_location AS event_location
FROM students
LEFT JOIN event
ON students.event_id = event.event_id;

SELECT *
FROM temp_students_events;

SELECT *
FROM event
JOIN ny_df
ON event.event_location LIKE CONCAT('%', ny_df.neighbourhood_group, '%')
HAVING MIN(price) AND availability_365 >= event_duration;

CREATE VIEW temp_events_accomodation AS
SELECT *
FROM event
JOIN ny_df
	ON event.event_location LIKE CONCAT('%', ny_df.neighbourhood_group, '%')
WHERE ny_df.availability_365 >= event.event_duration
	AND price = (
		SELECT MIN(price)
		FROM event
		JOIN ny_df
		ON event.event_location LIKE CONCAT('%', ny_df.neighbourhood_group, '%')
		WHERE ny_df.availability_365 >= event.event_duration
        AND price > 0
	);
    
SELECT *
FROM temp_events_accomodation;

SELECT *
FROM (
    SELECT 
        t.*,
        ROW_NUMBER() OVER (
            PARTITION BY event_id
            ORDER BY availability_365 DESC
        ) AS rn
    FROM temp_events_accomodation t
) AS ranked
WHERE rn = 1;

SET SQL_SAFE_UPDATES = 0;

UPDATE students AS st
JOIN (
    SELECT 
        t.event_id,
        t.accomodation_id,
        ROW_NUMBER() OVER (
            PARTITION BY t.event_id
            ORDER BY t.availability_365 DESC
        ) AS rn
    FROM temp_events_accomodation t
    WHERE t.room_type IN ('Entire home_apt', 'Private room')
) AS ranked
ON ranked.event_id = st.event_id
AND ranked.rn = 1
SET st.accomodation_id = ranked.accomodation_id;

SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM students AS s
JOIN ny_df AS ny
ON s.accomodation_id = ny.accomodation_id;