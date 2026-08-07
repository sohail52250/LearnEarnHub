function calculateMatch(userSkills, requiredSkills){

 let matched = 0;

 requiredSkills.forEach(skill=>{
   if(userSkills.includes(skill)){
     matched++;
   }
 });

 if(requiredSkills.length===0){
   return 0;
 }

 return Math.round(
   (matched / requiredSkills.length) * 100
 );

}


window.calculateMatch = calculateMatch;
