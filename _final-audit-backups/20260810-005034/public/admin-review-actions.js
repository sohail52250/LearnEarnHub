
async function updateStatus(table,id,status){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from(table)
.update({
status:status
})
.eq("id",id);


alert(
"Status updated"
);

}


window.updateStatus =
updateStatus;

