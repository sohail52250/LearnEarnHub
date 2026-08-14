(function(){

    async function loadLanguageSelector(){

        const target=document.getElementById("language-selector");

        if(!target){
            console.warn("LearnEarnHub: #language-selector not found");
            return;
        }

        try{

            const response=await fetch(
                "/language-selector.html",
                {cache:"no-store"}
            );

            if(!response.ok){
                throw new Error(
                    "Language selector HTTP "+response.status
                );
            }

            target.innerHTML=await response.text();

        }catch(error){

            console.error(
                "LearnEarnHub language selector error:",
                error
            );

        }

    }

    window.addEventListener(
        "DOMContentLoaded",
        loadLanguageSelector
    );

})();