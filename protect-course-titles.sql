CREATE UNIQUE INDEX IF NOT EXISTS courses_title_unique
ON courses (LOWER(TRIM(title_en)));
