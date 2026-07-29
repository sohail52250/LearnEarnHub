
const CACHE_NAME="learnearnhub-v1";

const FILES=[
"/",
"/index.html",
"/courses.html",
"/course-marketplace.html",
"/learner-dashboard.html",
"/manifest.json"
];


self.addEventListener("install",event=>{

event.waitUntil(
caches.open(CACHE_NAME)
.then(cache=>cache.addAll(FILES))
);

});


self.addEventListener("fetch",event=>{

event.respondWith(

caches.match(event.request)
.then(response=>{

return response || fetch(event.request);

})

);

});


