
async function loadCourseRatings(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client
.from("reviews")
.select("course_id,rating");


if(error || !data)return;


let ratings={};


data.forEach(function(review){

if(!ratings[review.course_id]){

ratings[review.course_id]=[];

}

ratings[review.course_id].push(
Number(review.rating)
);

});


Object.keys(ratings).forEach(function(id){

let values=ratings[id];

let average=
values.reduce((a,b)=>a+b,0)
/
values.length;


let box=document.getElementById(
"rating-"+id
);


if(box){

box.innerHTML=
"⭐ Average Rating: "+
average.toFixed(1)+
" / 5 ("+
values.length+
" reviews)";

}

});

}


document.addEventListener(
"DOMContentLoaded",
loadCourseRatings
);

