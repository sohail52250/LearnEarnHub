async function postAd(form){

const data={
user_id:localStorage.getItem("user_id"),
title:form.title.value,
title_ur:form.title_ur.value,
description:form.description.value,
description_ur:form.description_ur.value,
category:form.category.value,
contact:form.contact.value,
location:form.location.value
};


let r=await fetch("/api/ads",{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify(data)
});


return await r.json();

}
