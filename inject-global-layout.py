import glob

header='<div id="global-header"></div>'
footer='<div id="global-footer"></div>'


for f in glob.glob("public/*.html"):

    if "global-" in f:
        continue

    try:

        with open(f,encoding="utf8") as x:
            s=x.read()


        if "global-header" not in s:

            s=s.replace(
            "<body>",
            "<body>"+header
            )


        if "global-footer" not in s:

            s=s.replace(
            "</body>",
            footer+"</body>"
            )


        if "global-layout.js" not in s:

            s=s.replace(
            "</body>",
            '<script src="/global-layout.js"></script></body>'
            )


        with open(f,"w",encoding="utf8") as x:
            x.write(s)


    except:
        pass


print("Layout injected")
