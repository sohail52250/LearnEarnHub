
CREATE TABLE IF NOT EXISTS enterprise_course_assignments(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

employee_id uuid,

course_id uuid,

status text DEFAULT 'assigned',

progress integer DEFAULT 0,

completed_at timestamp,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_training_reports(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

employee_id uuid,

courses_completed integer DEFAULT 0,

skills text,

score integer DEFAULT 0,

created_at timestamp DEFAULT now()

);

