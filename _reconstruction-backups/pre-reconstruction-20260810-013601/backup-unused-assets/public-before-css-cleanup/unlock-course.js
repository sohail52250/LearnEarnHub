async function completeCourse(courseId, userId){

    try{

        const res = await fetch("/api/unlock-course",{
            method:"POST",
            headers:{
                "Content-Type":"application/json"
            },
            body:JSON.stringify({
                user_id:userId,
                completed_course_id:courseId
            })
        });

        const data = await res.json();

        if(data.success){

            alert(
              data.message +
              (data.course_id ? 
              "\nNext Course ID: " + data.course_id : "")
            );

            location.reload();

        }else{

            alert("Unlock failed:\n"+data.error);

        }

    }catch(err){

        alert("Network error: "+err.message);

    }

}
