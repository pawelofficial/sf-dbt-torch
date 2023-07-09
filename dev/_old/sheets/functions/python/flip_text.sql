create or replace function dev.dev.flip_text(text varchar)
returns varchar
language python
runtime_version = '3.8'
handler = 'flip_text'
PACKAGES =('numpy') -- package not used 
as
$$
def flip_text(text):
    char_map = {
        'a': '\u0250', 'b': 'q', 'c': '\u0254', 'd': 'p', 'e': '\u01DD', 'f': '\u025F', 
        'g': '\u0183', 'h': '\u0265', 'i': '\u0131', 'j': '\u027E', 'k': '\u029E',
        'l': '|', 'm': '\u026F', 'n': 'u', 'o': 'o', 'p': 'd', 'q': 'b', 'r': '\u0279',
        's': 's', 't': '\u0287', 'u': 'n', 'v': '\u028C', 'w': '\u028D', 'x': 'x', 
        'y': '\u028E', 'z': 'z', '.': '\u02D9', '[': ']', '(': ')', '{': '}',
        '?': '\u00BF', '!': '\u00A1', '"': '"', '\'': ',', '>': '<', '&': '\u214b',
        '_': '\u203E', '\u203F': '\u2040', '\u2045': '\u2046', '\r': '\n'
    }
    return "".join(char_map.get(c.lower(), c) for c in text[::-1])
$$;

select o_comment,dev.dev.flip_text(o_comment)
 from dev.dev.orders