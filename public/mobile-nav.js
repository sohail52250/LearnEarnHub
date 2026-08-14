
function createMobileNav(){

let nav=document.createElement("div");

nav.className="mobile-nav";


nav.innerHTML=`

<a href="/student-dashboard.html">
📊 Dashboard
</a>

<a href="/marketplace.html">
📚 Courses
</a>

<a href="/certificate.html">
🏆 Certificates
</a>

<a href="/auth/sign-in.html">
👤 Account
</a>

`;


document.body.appendChild(nav);


}


document.addEventListener(
"DOMContentLoaded",
createMobileNav
);

