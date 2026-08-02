const fs=require("fs");
const path=require("path");

function scan(dir){
  if(!fs.existsSync(dir)) return;

  for(const file of fs.readdirSync(dir)){
    const full=path.join(dir,file);

    if(fs.statSync(full).isDirectory()){
      scan(full);
    } else {
      const ext=path.extname(full);

      if([".js",".html",".sql"].includes(ext)){
        const txt=fs.readFileSync(full,"utf8");

        if(
          txt.includes("progress") ||
          txt.includes("completed") ||
          txt.includes("certificate") ||
          txt.includes("lesson_complete")
        ){
          console.log("\nFILE:",full);
          txt.split("\n")
          .filter(x =>
            x.includes("progress") ||
            x.includes("completed") ||
            x.includes("certificate")
          )
          .slice(0,5)
          .forEach(x=>console.log(x.trim()));
        }
      }
    }
  }
}

scan(".");
