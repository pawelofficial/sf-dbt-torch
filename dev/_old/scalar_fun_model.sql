{{ config(materialized='table') }}
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
        <img src="www.exampleimage.com/image1.jpg" alt="Example Image 1">
    </div>
    <div class="otherclass">
        <p>Another paragraph in another div.</p>
        <a href="www.example3.com">Example Link 3</a>
        <a href="www.example4.com">Example Link 4</a>
    </div>
</body>
</html>
' as html_column
)

select 
{{ use_fun('f__bs4_extract', ['html_column'], ['a', 'href']) }}  as bs4_href
,{{ use_fun('f__bs4_extract', ['html_column'], ['img', 'src']) }}  as bs4_img
from cte

