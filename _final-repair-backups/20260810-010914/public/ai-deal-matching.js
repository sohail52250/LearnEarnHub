
function calculateMatch(profileA, profileB){

let score = 0;


if(profileA.industry === profileB.industry){

score += 40;

}


if(profileA.location === profileB.location){

score += 20;

}


if(profileA.goal === profileB.goal){

score += 40;

}


return score;

}


window.calculateMatch = calculateMatch;

