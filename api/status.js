export default function handler(req,res){
 res.status(200).json({
  status:"online",
  platform:"LearnEarnHub",
  version:"refined",
  language:["en","ur"],
  time:new Date().toISOString()
 });
}
