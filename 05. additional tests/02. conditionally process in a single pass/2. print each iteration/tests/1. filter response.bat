@echo off

call "%~dp0..\..\..\..\00_common\env.test.bat"

set logfile="%~dp02. output.response.txt"

set wget_opts=-O -
set wget_opts=%wget_opts% --quiet

set print_content_url="http://localhost:81/test.html"

rem :: http://www.gnu.org/software/wget/manual/wget.html#Proxies
set http_proxy=http://127.0.0.1:8080/

wget.exe %wget_opts% %print_content_url% >%logfile%
