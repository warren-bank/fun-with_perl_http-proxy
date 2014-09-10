@echo off

call "%~dp0..\..\00_common\env.test.bat"

set logfile="%~dp03. output.requests.txt"

set wget_opts=-O -
set wget_opts=%wget_opts% --header="Accept-Charset: utf-8"
set wget_opts=%wget_opts% --header="Accept-Language: en"
set wget_opts=%wget_opts% --header="User-Agent: Firefox"
set wget_opts=%wget_opts% --header="From: warren"
set wget_opts=%wget_opts% --header="Referer: warren"
set wget_opts=%wget_opts% --header="Cookie: tester=warren"

set echo_headers_url="http://headers.jsontest.com/"
set echo_headers_url="http://httpbin.org/headers"

echo ------------------------------------------------->%logfile%
echo headers - no proxy:>>%logfile%
echo.>>%logfile%

wget.exe %wget_opts% --no-proxy %echo_headers_url% >>%logfile%

echo.>>%logfile%
echo ------------------------------------------------->>%logfile%
echo headers - using perl http proxy:>>%logfile%
echo.>>%logfile%

rem :: http://www.gnu.org/software/wget/manual/wget.html#Proxies
set http_proxy=http://127.0.0.1:8080/

wget.exe %wget_opts% %echo_headers_url% >>%logfile%

echo.>>%logfile%
echo ------------------------------------------------->>%logfile%
