rem Set Execution Policy (64-Bit)
%SystemRoot%\System32\cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"
rem %SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe

rem Set Execution Policy (32-Bit)
%SystemRoot%\SysWOW64\cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"
rem %SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe
