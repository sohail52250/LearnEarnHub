
function askAssistant(){

let question=document
.getElementById("assistant-question")
.value
.toLowerCase();


let answer="";


if(question.includes("word")){

answer="Start with Word Basics. Learn documents, formatting, tables and CV creation.";

}

else if(question.includes("excel")){

answer="Start with Excel Basics. Learn formulas, budgets and data management.";

}

else if(question.includes("html") || question.includes("website")){

answer="Learn HTML Basics first, then CSS to design webpages.";

}

else if(question.includes("job") || question.includes("freelance")){

answer="Learn Freelancing Basics, create a profile and build practical projects.";

}

else if(question.includes("computer")){

answer="Begin with Windows Basics, File Management and Internet Browsing.";

}

else{

answer="Recommended path: Computer Basics → Office Skills → Digital Skills → Freelancing.";

}


document.getElementById(
"assistant-answer"
).innerHTML=answer;


}

