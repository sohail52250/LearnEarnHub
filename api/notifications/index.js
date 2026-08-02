const queue=require("../../services/notifications/queue");

module.exports=(req,res)=>{

if(req.method==="GET"){
 return res.json(queue.list());
}

if(req.method==="POST"){
 queue.add(req.body);
 return res.json({success:true});
}

res.status(405).end();
};
