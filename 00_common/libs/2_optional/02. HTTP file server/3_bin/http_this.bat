@echo off

call "%~dp0..\..\..\..\env.bat"

set perl_opts=%perl_opts% -I"%~dp0..\2_inc"

perl.exe %perl_opts% "%~dpn0.pl" %*
