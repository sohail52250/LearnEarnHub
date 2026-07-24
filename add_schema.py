from pathlib import Path
import json

count=0

for p in Path("public").rglob("*.html"):

    text=p.read_text()

    if "schema.org" in text:
        continue

    name=p.stem.replace("-"," ").title()

    schema={
        "@context":"https://schema.org",
        "@type":"EducationalOrganization",
        "name":"Learn & Earn Hub",
        "url":"https://learn-earnhub.vercel.app",
        "description":"Free online platform for learning computer skills, digital skills, and beginner courses."
    }

    if "lessons" in str(p):

        schema={
            "@context":"https://schema.org",
            "@type":"Course",
            "name":name,
            "provider":{
                "@type":"Organization",
                "name":"Learn & Earn Hub",
                "url":"https://learn-earnhub.vercel.app"
            },
            "description":f"Learn {name} with beginner-friendly lessons on Learn & Earn Hub."
        }


    block=f"""
<script type="application/ld+json">
{json.dumps(schema,indent=2)}
</script>
"""

    text=text.replace(
        "</head>",
        block+"\n</head>"
    )

    p.write_text(text)
    count+=1


print("Schema added to",count,"pages")
