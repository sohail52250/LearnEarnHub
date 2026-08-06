drop policy if exists "Users can read own role" on user_roles;

create policy "Users can read own role"
on user_roles
for select
to authenticated
using (auth.uid() = user_id);
