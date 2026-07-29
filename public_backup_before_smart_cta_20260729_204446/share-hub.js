function shareHub(){

const url = window.location.origin;

if(navigator.share){

navigator.share({

title:"Learn & Earn Hub",

text:"Learn computer and digital skills step by step with Learn & Earn Hub",

url:url

});

}else{

navigator.clipboard.writeText(url);

alert("Website link copied! Share it with your friends.");

}

}
