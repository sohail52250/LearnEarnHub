create table if not exists system_backups(
id bigint generated always as identity primary key,
name text,
git_commit text,
deployment text,
status text,
audit_result text,
created_at timestamp default now()
);
