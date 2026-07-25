from pathlib import Path

count=0

for p in Path("public/lessons").glob("*.html"):

    text=p.read_text()

    if "language-switch.js" not in text:

        text=text.replace(
        "</head>",
        """
<script src="/language-switch.js"></script>
</head>
"""
        )


    if 'id="lang-buttons"' not in text:

        text=text.replace(
        "<body>",
        """
<body>

<div id="lang-buttons" class="card">

<button onclick="setLanguage('en')">
English
</button>

<button onclick="setLanguage('ur')">
اردو
</button>

</div>

"""
        )


    p.write_text(text)
    count+=1


print("Course pages updated:",count)
