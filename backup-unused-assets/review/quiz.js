async function submitQuiz(quizName, correctAnswer){

let selected=document.querySelector(
'input[name="answer"]:checked'
);

if(!selected){
alert("Please select an answer");
return;
}

let score = selected.value === correctAnswer ? 100 : 0;


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

alert("Please login first");
return;

}


const {error}=await client
.from("quiz_results")
.insert({

user_id:userData.user.id,
quiz:quizName,
score:score

});


if(error){

alert(error.message);
return;

}


if(score===100){

alert("🎉 Quiz Passed!");

}else{

alert("Keep practicing and try again.");

}

}
