
#!/data/data/com.termux/files/usr/bin/bash

echo "Adding task review protection..."


python - <<'PY'

from pathlib import Path

p=Path("public/task-review-center.js")

data=p.read_text()


old="const client = supabaseClient;"


new="""const client = supabaseClient;


// Access protection

async function checkReviewerAccess(){

const user = JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

document.body.innerHTML =
"Please login first";

throw new Error("No user");

}


// Check admin table

const {data:admin}=await client

.from("admin_users")

.select("*")

.eq("user_id",user.id)

.single();



if(!admin){

document.body.innerHTML =
"Access denied. Reviewer only.";

throw new Error("No permission");

}


}


"""


if "checkReviewerAccess" not in data:
    data=data.replace(old,new)


data=data.replace(
"loadSubmissions();",
"checkReviewerAccess().then(loadSubmissions);",
1
)


p.write_text(data)

PY


echo "Protection added"

