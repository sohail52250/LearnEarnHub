
-- Computer Fundamentals Root Course

INSERT INTO course_catalog
(
 title,
 description,
 level,
 category,
 status
)
SELECT
'Computer Fundamentals',
'Beginner computer course. Start from zero and learn computer basics before digital skills and earning skills.',
'Beginner',
'Computer Basics',
'active'
WHERE NOT EXISTS
(
 SELECT 1 FROM course_catalog
 WHERE title='Computer Fundamentals'
);


-- Lessons

INSERT INTO lessons
(course_id,title,description,lesson_order)
SELECT
c.id,
x.title,
x.description,
x.lesson_order
FROM course_catalog c,
(
VALUES
('What is a Computer?','Introduction to computers and basic concepts.',1),
('Computer Parts','Learn hardware components.',2),
('Start and Shutdown','Learn safe computer startup and shutdown.',3),
('Keyboard and Mouse','Learn basic input devices.',4),
('Windows Basics','Learn Windows operating system basics.',5),
('Files and Folders','Manage files and folders.',6),
('Internet Basics','Understand internet fundamentals.',7),
('Email Basics','Create and use email professionally.',8),
('Online Safety','Stay safe online.',9)
)x(title,description,lesson_order)
WHERE c.title='Computer Fundamentals'
AND NOT EXISTS
(
 SELECT 1 FROM lessons 
 WHERE title=x.title
);


-- Add roadmap priority if table exists
UPDATE course_catalog
SET category='Root Beginner Course'
WHERE title='Computer Fundamentals';

