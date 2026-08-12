const fs=require("fs");
const path=require("path");

const root=process.cwd();

const required=[
    "public/businesses/register.html",
    "api/businesses.js",
    "services/business-service.js",
    "database/business-foundation.sql",
    "api/index.js"
];

for(const file of required){
    const full=path.join(root,file);

    if(!fs.existsSync(full)){
        throw new Error("Missing required file: "+file);
    }

    if(fs.statSync(full).size===0){
        throw new Error("Empty required file: "+file);
    }
}

const page=fs.readFileSync(
    path.join(root,"public/businesses/register.html"),
    "utf8"
);

const api=fs.readFileSync(
    path.join(root,"api/businesses.js"),
    "utf8"
);

const router=fs.readFileSync(
    path.join(root,"api/index.js"),
    "utf8"
);

const checks=[
    ["business_name",page],
    ["contact_person_name",page],
    ["contact_email",page],
    ["current_activities",page],
    ["introducer_name",page],
    ["introducer_reference",page],
    ["task_description",page],
    ["payment_amount",page],
    ["frequency",page],
    ["time_required_minutes",page],
    ["deadline",page],
    ['app.use("/businesses"',router],
    ['createTask',api]
];

for(const [needle,text] of checks){
    if(!text.includes(needle)){
        throw new Error("Required feature missing: "+needle);
    }
}

console.log("Business foundation static checks: PASS");
