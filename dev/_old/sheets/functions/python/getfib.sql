create or replace function dev.dev.getfib(i int)
returns int
language python
runtime_version = '3.8'
handler = 'getfib'
--PACKAGES =('numpy')
as
$$
def getfib(n):
    if n <= 0:
        return "Input should be a positive integer."
    elif n == 1:
        return 0
    elif n == 2:
        return 1
    else:
        return getfib(n-1) + getfib(n-2)
$$;

select dev.dev.getfib(10);

