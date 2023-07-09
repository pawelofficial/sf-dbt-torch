{% macro f__bs4_extract() %}
    {% set query -%}
--- fun start here  
create or replace function f__bs4_extract(s varchar,element varchar,attribute varchar)
returns varchar
language python
runtime_version = '3.8'
handler = 'f__bs4_extract'
PACKAGES =('bs4')
as
$$
from bs4 import BeautifulSoup
def f__bs4_extract(s,element='a',attribute='href'):
    soup = BeautifulSoup(s)
    a_tags = soup.find_all(element)
    tags=[tag.get(attribute) for tag in a_tags]
    return f"{tags}"
$$;
--- fun end here 
{%- endset -%}
    {{ run_query(query) }}
{% endmacro %}

-- bs4_extract(s, 'img', 'src')
--bs4_extract(s, 'a', 'href')
