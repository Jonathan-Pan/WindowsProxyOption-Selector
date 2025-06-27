@REM #
@REM # The MS-DOS batch file is used to call PowerShell Script - 'Set-ProxyOption_CLI-GUI.ps1' for update OS proxy options on-demand.
@REM # 
@REM # Author: Jian-Hua Pan(Jonathan)
@REM # Email 1& MS Teams: hdpanjianhua@msn.com
@REM # Email 2: fdpjh@126.com

@REM # Version: 2.0
@REM # Created on 2024-06-22

@ECHO OFF
rem SET PSScript=Set-ProxyOption.ps1
SET PSScript=Set-ProxyOption_CLI-GUI.ps1
powershell.exe -ExecutionPolicy RemoteSigned -NoExit -WindowStyle Normal -Command ". .\%PSScript%"
@REM EXIT /B
@REM cmd /k
