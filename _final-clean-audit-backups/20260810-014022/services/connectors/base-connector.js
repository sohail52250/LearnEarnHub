
class BaseConnector {


constructor(name){

this.name=name;

}



async fetch(){

return [];

}



normalize(job){

return {

title:job.title || "",

company:job.company || "",

description:job.description || "",

required_skill:job.skill || "",

country:job.country || "Global",

remote:job.remote || false,

apply_url:job.url || ""

};

}


}



module.exports=BaseConnector;

