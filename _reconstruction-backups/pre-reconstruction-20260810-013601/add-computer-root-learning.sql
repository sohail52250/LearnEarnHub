-- LearnEarnHub Root Beginner Course
-- Computer Fundamentals

INSERT INTO courses
(title, description, level, category)
SELECT
'Computer Fundamentals',
'Start from zero. Learn computer basics before advanced digital skills, freelancing and earning.',
'Beginner',
'Computer Basics'
WHERE NOT EXISTS (
SELECT 1 FROM courses
WHERE title='Computer Fundamentals'
);


-- Lessons

INSERT INTO course_lessons
(course_id, title, description, lesson_order)

SELECT
c.id,
x.title,
x.description,
x.lesson_order

FROM courses c,

(VALUES

('What is a Computer?',
'Understand computers, uses and basic concepts.',
1),

('Computer Parts',
'Learn CPU, monitor, keyboard, mouse and hardware.',
2),

('Start and Shutdown',
'Learn correct computer startup and shutdown.',
3),

('Keyboard and Mouse',
'Learn typing and mouse control basics.',
4),

('Windows Basics',
'Learn desktop, settings and applications.',
5),

('Files and Folders',
'Create, save and manage files.',
6),

('Internet Basics',
'Learn browsers, websites and online searching.',
7),

('Email Basics',
'Create and use email professionally.',
8),

('Online Safety',
'Protect accounts and personal information.',
9)

)x(title,description,lesson_order)

WHERE c.title='Computer Fundamentals'

AND NOT EXISTS
(
SELECT 1
FROM course_lessons l
WHERE l.title=x.title
);


-- Make it first priority

UPDATE courses
SET category='Root Beginner Course'
WHERE title='Computer Fundamentals';

