from pathlib import Path
import json

count=0

for p in Path("public/lessons").glob("*.html"):

    text=p.read_text()

    name=p.stem.replace("-"," ").title()

    schema={
        "@context":"https://schema.org",
        "@type":"Course",
        "name":name,
        "description":f"Beginner friendly {name} course from Learn & Earn Hub.",
        "provider":{
            "@type":"Organization",
            "name":"Learn & Earn Hub",
            "url":"https://learn-earnhub.vercel.app"
        },
        "educationalLevel":"Beginner",
        "inLanguage":"en",
        "isAccessibleForFree":True
    }

    breadcrumb={
        "@context":"https://schema.org",
        "@type":"BreadcrumbList",
        "itemListElement":[
            {
                "@type":"ListItem",
                "position":1,
                "name":"Home",
                "item":"https://learn-earnhub.vercel.app"
            },
            {
                "@type":"ListItem",
                "position":2,
                "name":name
            }
        ]
    }

    block=f"""
<script type="application/ld+json">
{json.dumps(schema,indent=2)}
</script>

<script type="application/ld+json">
{json.dumps(breadcrumb,indent=2)}
</script>
"""

    if "BreadcrumbList" not in text:
        text=text.replace("</head>",block+"\n</head>")
        p.write_text(text)
        count+=1

print("Course schema upgraded:",count)
