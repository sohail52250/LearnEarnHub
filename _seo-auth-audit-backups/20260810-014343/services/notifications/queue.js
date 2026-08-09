const queue=[];

function add(item){
 queue.push({
  ...item,
  created_at:new Date().toISOString()
 });
 return true;
}

function list(){
 return queue;
}

module.exports={add,list};
