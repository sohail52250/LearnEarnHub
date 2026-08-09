
if("serviceWorker" in navigator){

navigator.serviceWorker.register("/service-worker.js")
.then(()=>{
console.log("LearnEarnHub Offline Mode Ready");
});

}

