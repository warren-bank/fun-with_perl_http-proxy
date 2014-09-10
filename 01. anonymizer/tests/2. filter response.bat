@echo off

call "%~dp0..\..\00_common\env.test.bat"

set logfile="%~dp04. output.response.txt"

set wget_opts=-O -
set wget_opts=%wget_opts% --quiet
set wget_opts=%wget_opts% --server-response

set print_headers_url="http://urlecho.appspot.com/echo?status=200&Content-Type=text/html&Set-Cookie=name1=value1,name2=value2&body=Hello+world!"

echo ------------------------------------------------->%logfile%
echo headers - no proxy:>>%logfile%
echo.>>%logfile%

wget.exe %wget_opts% --no-proxy %print_headers_url% 2>>%logfile%

echo.>>%logfile%
echo ------------------------------------------------->>%logfile%
echo headers - using perl http proxy:>>%logfile%
echo.>>%logfile%

rem :: http://www.gnu.org/software/wget/manual/wget.html#Proxies
set http_proxy=http://127.0.0.1:8080/

wget.exe %wget_opts% %print_headers_url% 2>>%logfile%

echo.>>%logfile%
echo ------------------------------------------------->>%logfile%
