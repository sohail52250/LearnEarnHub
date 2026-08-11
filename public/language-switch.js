(function(){

    let currentLanguage =
        localStorage.getItem("leh_lang") ||
        localStorage.getItem("language") ||
        "en";

    async function setLanguage(lang){

        if(!["en","ur","ar","nl"].includes(lang)){
            lang="en";
        }

        currentLanguage=lang;

        localStorage.setItem("leh_lang",lang);
        localStorage.setItem("language",lang);

        await loadLanguage(lang);

    }

    async function loadLanguage(lang){

        if(lang){
            currentLanguage=lang;
        }

        try{

            const response=await fetch(
                "/translations/"+encodeURIComponent(currentLanguage)+".json",
                {cache:"no-store"}
            );

            if(!response.ok){
                throw new Error(
                    "Translation HTTP "+response.status
                );
            }

            const words=await response.json();

            document.querySelectorAll("[data-i18n]").forEach(
                function(el){

                    const key=el.getAttribute("data-i18n");

                    if(words[key] !== undefined){
                        el.textContent=words[key];
                    }

                }
            );

            document.querySelectorAll("[data-key]").forEach(
                function(el){

                    const key=el.getAttribute("data-key");

                    if(words[key] !== undefined){
                        el.textContent=words[key];
                    }

                }
            );

            document.documentElement.lang=currentLanguage;

            if(
                currentLanguage==="ur" ||
                currentLanguage==="ar"
            ){
                document.documentElement.dir="rtl";
            }else{
                document.documentElement.dir="ltr";
            }

        }catch(error){

            console.error(
                "LearnEarnHub translation error:",
                error
            );

        }

    }

    window.setLanguage=setLanguage;
    window.loadLanguage=loadLanguage;

    document.addEventListener(
        "DOMContentLoaded",
        function(){
            loadLanguage(currentLanguage);
        }
    );

})();