
CREATE TABLE IF NOT EXISTS investor_alerts (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

alert_type text,

title text,

message text,

status text DEFAULT 'unread',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS automation_workflows (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

workflow_name text,

trigger_event text,

action text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS scheduled_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

report_type text,

schedule text,

last_generated timestamp,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS ai_monitoring_events (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

event_type text,

risk_level text,

message text,

created_at timestamp DEFAULT now()

);

