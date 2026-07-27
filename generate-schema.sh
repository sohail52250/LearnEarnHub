#!/data/data/com.termux/files/usr/bin/bash

OUT=supabase_schema.sql

echo "-- AUTO GENERATED" > $OUT

while read table
do
cat >> $OUT <<SQL

CREATE TABLE IF NOT EXISTS $table (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE $table ENABLE ROW LEVEL SECURITY;

SQL

done < all_tables.txt

echo "Created $OUT"
