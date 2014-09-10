@echo off

call "%~dp0..\..\..\00_common\env.test.bat"

set logfile="%~dp02. output.response.txt"

set wget_opts=-O -
set wget_opts=%wget_opts% --quiet

if exist %logfile% del %logfile%

call :run_iteration "THE CLOUD"
call :run_iteration "The Cloud"
call :run_iteration "The cloud"
call :run_iteration "tHE CLoud"
call :run_iteration "the cloud"

goto done

:run_iteration

	set cloud_string=%~1
	set cloud_string=%cloud_string: =+%
	set print_content_url="http://urlecho.appspot.com/echo?status=200&Content-Type=text/html&body=Everything+is+better+when+it+is+in+%cloud_string%"

	echo ------------------------------------------------->>%logfile%
	echo content - no proxy:>>%logfile%
	echo.>>%logfile%

	wget.exe %wget_opts% --no-proxy %print_content_url% >>%logfile%

	echo.>>%logfile%
	echo ------------------------------------------------->>%logfile%
	echo content - using perl http proxy:>>%logfile%
	echo.>>%logfile%

	rem :: http://www.gnu.org/software/wget/manual/wget.html#Proxies
	set http_proxy=http://127.0.0.1:8080/

	wget.exe %wget_opts% %print_content_url% >>%logfile%

	echo.>>%logfile%
	echo ------------------------------------------------->>%logfile%
	goto :eof

:done
