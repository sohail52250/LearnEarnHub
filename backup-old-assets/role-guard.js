async function protectPage(){

const page =
location.pathname;


if(page.includes("admin-control-center")){

await requireRole([
"admin"
]);

}


if(page.includes("employer-dashboard")
|| page.includes("business-marketplace")){

await requireRole([
"business",
"sponsor"
]);

}


if(page.includes("learner-dashboard")){

await requireRole([
"learner"
]);

}


}


window.addEventListener(
"load",
protectPage
);
