async function loadNotifications(){

    const user =
        JSON.parse(localStorage.getItem("user") || "null");

    if(!user){
        document.getElementById("notifications").innerHTML =
        "Please login.";
        return;
    }

    const {data,error} =
        await supabaseClient
        .from("business_notifications")
        .select("*")
        .eq("business_id", user.id)
        .order("created_at",{ascending:false});

    if(error){
        document.getElementById("notifications").innerHTML =
        error.message;
        return;
    }

    document.getElementById("notifications").innerHTML =
    (data || []).map(n => `
        <div class="card">
            <h3>${n.title}</h3>
            <p>${n.message}</p>
            <small>${n.created_at}</small>
        </div>
    `).join("");
}

document.addEventListener(
    "DOMContentLoaded",
    loadNotifications
);
