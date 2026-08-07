
async function completeTask(taskId){

const user=
JSON.parse(localStorage.getItem("user")||"null");


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {error}=await client
.from("task_progress")
.insert({

task_id:taskId,

learner_id:user.id,

progress_status:"completed",

completion_note:
"Task completed by learner"

});


alert(
error ?
error.message :
"Completion submitted for approval"
);


}



window.completeTask=completeTask;

