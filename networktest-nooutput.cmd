@echo off

REM Set the IP address to be tested
set ip_address=8.8.8.8

REM Set the title of the script
title Alias Ping Test

REM Enable delayed expansion for using variables within loops
setlocal EnableDelayedExpansion

REM Initialize success and failure counters to zero
set success=0
set failure=0

:loop
REM Get the current date/time
set "datetime=!date:~6,4!-!date:~3,2!-!date:~0,2!_!time::=-!"
set "datetime=!datetime:.=_!"

REM Ping the specified IP address once with a timeout of 1 second
ping %ip_address% -n 1 -w 1000 > nul

REM Check the errorlevel to see if the ping failed
if errorlevel 1 (
    REM If the ping failed, increment the failure counter 
    set /a failure+=1

    REM Create the Results directory if it doesn't exist
REM    if not exist Results mkdir Results

    REM Output the network information to separate files with the current date/time in the filename
REM    netsh wlan show all       > Results\%datetime%_netsh_wlan_show_all.txt
REM    netsh wlan show interface > Results\%datetime%_netsh_wlan_show_interface.txt
REM    ipconfig /all             > Results\%datetime%_ipconfig_all.txt
) else (
    REM If the ping succeeded, increment the success counter
    set /a success+=1
)

REM Calculate the total number of pings and pass rate percentage
set /a total=%success% + %failure%
set /a pass_rate=(%success% * 100) / (%total%)

REM Clear the console and output the results
cls
echo Constant Ping Test
echo ------------------
echo IP Address: %ip_address%
echo Successful pings: %success%
echo Failed pings: %failure%
echo Pass rate: %pass_rate%%% (%success%/%total%)
echo ------------------
echo Press CTRL + C to exit...

REM Delay for 2 seconds and loop back to the beginning
ping -n 2 127.0.0.1 > nul
goto loop
