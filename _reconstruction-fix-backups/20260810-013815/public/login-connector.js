async function loginUser(email,password){

    try{

        const response = await fetch("/api/auth",{

            method:"POST",

            headers:{
                "Content-Type":"application/json"
            },

            body:JSON.stringify({
                email,
                password
            })

        });


        const data = await response.json();


        if(!response.ok){

            alert(data.error || "Login failed");
            return false;

        }


        if(typeof saveSession==="function"){

            saveSession(data);

        }else{

            localStorage.setItem(
                "token",
                data.token || ""
            );

            localStorage.setItem(
                "user",
                JSON.stringify(data.user || {})
            );

            localStorage.setItem(
                "role",
                data.user?.role || "learner"
            );

        }


        alert("Login successful");


        const role=data.user?.role || "learner";


        if(role==="admin"){

            location.href="/admin-control-dashboard.html";

        }else if(role==="business"){

            location.href="/business-dashboard.html";

        }else if(role==="instructor"){

            location.href="/instructor-dashboard.html";

        }else{

            location.href="/student-dashboard.html";

        }


        return true;


    }catch(error){

        console.error(error);

        alert("Server error");

        return false;

    }

}
