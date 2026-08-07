const SUPABASE_URL = "https://srarnaqyoiqotdntzsyc.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNyYXJuYXF5b2lxb3RkbnR6c3ljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQ4ODc0MjgsImV4cCI6MjEwMDQ2MzQyOH0.e8SJDfYz6jLRm_aoy5poUOYApw0OJF3SFKNKeYf4O7k";

const supabaseClient = supabase.createClient(
  SUPABASE_URL,
  SUPABASE_ANON_KEY
);
