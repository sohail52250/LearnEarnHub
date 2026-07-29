(function(){

const saved = localStorage.getItem("leh-theme");

if(saved==="dark"){
    document.documentElement.setAttribute("data-theme","dark");
}

window.toggleLEHTheme=function(){

let html=document.documentElement;

if(html.getAttribute("data-theme")==="dark"){

    html.removeAttribute("data-theme");
    localStorage.setItem("leh-theme","light");

}else{

    html.setAttribute("data-theme","dark");
    localStorage.setItem("leh-theme","dark");

}

};

})();
