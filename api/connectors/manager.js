const sources=[];

function addSource(source){
 sources.push(source);
}

function getSources(){
 return sources;
}

module.exports={
 addSource,
 getSources
};
