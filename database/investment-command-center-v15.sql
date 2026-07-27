
CREATE TABLE IF NOT EXISTS command_center_widgets (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

widget_name text,

widget_data text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_pipeline (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

deal_id uuid,

stage text DEFAULT 'review',

priority text DEFAULT 'normal',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS intelligence_notifications (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

title text,

message text,

priority text DEFAULT 'normal',

created_at timestamp DEFAULT now()

);

