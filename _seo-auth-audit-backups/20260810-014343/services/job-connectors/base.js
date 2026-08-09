class BaseConnector {


constructor(name){

this.name=name;

}



async fetchJobs(){

return [];

}



normalize(job){

return {

external_id:job.id || Date.now().toString(),

title:job.title || "",

company:job.company || "",

description:job.description || "",

required_skills:job.skills || "",

country:job.country || "Global",

remote:job.remote || false,

salary:job.salary || "",

apply_url:job.url || "",

source_name:this.name

};

}


}


module.exports=BaseConnector;

