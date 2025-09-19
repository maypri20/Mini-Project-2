USE miniproject2;

# Update event_id of student table to the same values as event_id in the event table
SET SQL_SAFE_UPDATES = 0;

UPDATE students AS st 
JOIN event AS ev
ON st.student_id = ev.event_id
SET st.event_id = ev.event_id;

SET SQL_SAFE_UPDATES = 1;

# Verification
SELECT * 
FROM students AS st 
JOIN event AS ev
ON st.student_id = ev.event_id;