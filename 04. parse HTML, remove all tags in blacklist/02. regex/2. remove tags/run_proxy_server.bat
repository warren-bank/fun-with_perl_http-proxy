@echo off

call "%~dp0..\..\..\00_common\env.bat"

set perl_script="%~dp0proxy_server.pl"

perl.exe %perl_opts% %perl_script% >%perl_script%.log 2>&1
