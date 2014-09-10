@echo off

set httpd_bat="%~dp0..\..\..\00_common\libs\2_optional\02. HTTP file server\3_bin\http_this.bat"
set httpd_port=81
set doc_root="%~dp0htdoc"

call %httpd_bat% --port %httpd_port% %doc_root% >"%~dpnx0.log" 2>&1
