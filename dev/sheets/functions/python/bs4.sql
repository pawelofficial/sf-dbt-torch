create or replace function dev.dev.bs4(s varchar)
returns varchar
language python
runtime_version = '3.8'
handler = 'bs4'
PACKAGES =('bs4')
as
$$
from bs4 import BeautifulSoup
def bs4(s):
    soup = BeautifulSoup(s)
    a_tags = soup.find_all('a')
    tags=[tag.get('href') for tag in a_tags]
    return f"{tags}"
$$;



with cte as ( 
    select '<html>
<head>
    <title>Test Page</title>
</head>
<body>
    <h1>My First Heading</h1>
    <p>My first paragraph.</p>
    <div class="myclass" id="myid">
        <p>This is a paragraph inside a div.</p>
        <a href="www.example.com">Example Link 1</a>
        <a href="www.example2.com">Example Link 2</a>
    </div>
    <div class="otherclass">
        <p>Another paragraph in another div.</p>
        <a href="www.example3.com">Example Link 3</a>
        <a href="www.example4.com">Example Link 4</a>
    </div>
</body>
' as example
)
select dev.dev.bs4(example)
from cte