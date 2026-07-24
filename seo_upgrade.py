from pathlib import Path
import re

base="https://learn-earnhub.vercel.app"

count=0

for p in Path("public").rglob("*.html"):

    text=p.read_text()

    if "<title>" in text:
        title=re.search(r"<title>(.*?)</title>", text, re.I)
        if title:
            page_title=title.group(1)
        else:
            page_title=p.stem.replace("-"," ").title()+" | Learn & Earn Hub"
    else:
        page_title=p.stem.replace("-"," ").title()+" | Learn & Earn Hub"

    description=(
        f"Learn {p.stem.replace('-', ' ')} and improve your computer "
        "and digital skills with Learn & Earn Hub. Free beginner-friendly lessons."
    )

    canonical=f"{base}/{p.relative_to('public')}"

    seo=f"""
<title>{page_title}</title>

<meta name="description" content="{description}">
<meta name="keywords" content="computer skills, digital skills, online learning, beginner courses, Learn Earn Hub">

<meta property="og:title" content="{page_title}">
<meta property="og:description" content="{description}">
<meta property="og:type" content="website">
<meta property="og:url" content="{canonical}">

<link rel="canonical" href="{canonical}">
"""

    if "og:title" not in text:

        text=text.replace(
            "</head>",
            seo+"\n</head>"
        )

        p.write_text(text)
        count+=1

print("SEO upgraded pages:",count)
