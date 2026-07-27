export default function handler(req,res){
 res.status(200).json({
  status:"online",
  platform:"LearnEarnHub",
  version:"refined",
  languages:["en","ur"],
  timestamp:new Date().toISOString()
 });
}
