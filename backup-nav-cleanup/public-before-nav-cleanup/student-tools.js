
async function saveNote(lesson){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:user}=await client.auth.getUser();

if(!user.user)return;


let note=document.getElementById(
"note-"+lesson
).value;


await client
.from("student_notes")
.insert({

user_id:user.user.id,

lesson:lesson,

note:note

});


alert("Note saved");

}



async function bookmarkLesson(lesson){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:user}=await client.auth.getUser();

if(!user.user)return;


await client
.from("lesson_bookmarks")
.insert({

user_id:user.user.id,

lesson:lesson

});


alert("Lesson bookmarked ⭐");

}

