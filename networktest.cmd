REM Paul McManus 2023 01 31
REM Constant Ping

REM Make it look less intimidating
echo off
title Network Test
cls
color F0

REM Reset Counters
set counttotal=0
set countfail=0

REM Start Point for every loop
:start

REM Ping Google DNS and store if it's successful or not in variable "pingtest"
ping 8.8.8.8 -n 1|Find "TTL=">Nul&&(set pingtest=PASS)||set pingtest=FAIL

REM Get the date and time
set dt=%DATE:~6,4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%_%TIME:~6,2%
set dt=%dt: =0%

REM Set the filenames for the (potential) logs with the date/time info
set log1=fail\%dt%-netshWLANshowALL.txt
set log2=fail\%dt%-netshWLANshowINTERFACE.txt
set log3=fail\%dt%-ipconfigALL.txt

REM If the ping fails, run this loop
REM Adding to fail count
REM Creating fail directory if it doesn't already exist
REM Running the tests requested by Service Desk and saving the output into files
REM Currently a 10 second count between fails. To be adjusted before sharing
if %pingtest% == FAIL (
set /a "countfail=%countfail%+1"
if not exist fail\ (mkdir fail)
netsh wlan show all > %log1%
netsh wlan show interface > %log2%
ipconfig /all > %log3%
echo.
echo.
echo and that's a fail...
timeout 10
)

REM Add to the total count, irrespective of failure or not
set /a "counttotal=%counttotal%+1"

REM Print the normal page with the current counts
cls
echo PPPPPPPPPPPPPPPPP                                    lllllll                  
echo P::::::::::::::::P                                   l:::::l  :::               
echo P::::::PPPPPP:::::P                                  l:::::l  :::               
echo PP:::::P     P:::::P                                 l:::::l :::                
echo   P::::P     P:::::Paaaaaaaaaaaaa  uuuuuu    uuuuuu   l::::l     ssssssssss   
echo   P::::P     P:::::Pa::::::::::::a u::::u    u::::u   l::::l   ss::::::::::s  
echo   P::::PPPPPP:::::P aaaaaaaaa:::::au::::u    u::::u   l::::l ss:::::::::::::s 
echo   P:::::::::::::PP           a::::au::::u    u::::u   l::::l s::::::ssss:::::s
echo   P::::PPPPPPPPP      aaaaaaa:::::au::::u    u::::u   l::::l  s:::::s  ssssss 
echo   P::::P            aa::::::::::::au::::u    u::::u   l::::l    s::::::s      
echo   P::::P           a::::aaaa::::::au::::u    u::::u   l::::l       s::::::s   
echo   P::::P          a::::a    a:::::au:::::uuuu:::::u   l::::l ssssss   s:::::s 
echo PP::::::PP        a::::a    a:::::au:::::::::::::::uul::::::ls:::::ssss::::::s
echo P::::::::P        a:::::aaaa::::::a u:::::::::::::::ul::::::ls::::::::::::::s 
echo P::::::::P         a::::::::::aa:::a uu::::::::uu:::ul::::::l s:::::::::::ss  
echo PPPPPPPPPP          aaaaaaaaaa  aaaa   uuuuuuuu  uuuullllllll  sssssssssss                        
echo   _   _      _                      _             _____         _            
echo "| \ | | ___| |___      _____  _ __| | __        |_   _|__  ___| |_ ___ _ __ "
echo "|  \| |/ _ \ __\ \ /\ / / _ \| '__| |/ /          | |/ _ \/ __| __/ _ \ '__|"
echo "| |\  |  __/ |_ \ V  V / (_) | |  |   <           | |  __/\__ \ ||  __/ |   "
echo "|_| \_|\___|\__| \_/\_/ \___/|_|  |_|\_\    v1    |_|\___||___/\__\___|_|   "
echo.
echo Test ran %counttotal% times
echo Test failed %countfail% times
echo.
echo Press CTRL + C to exit
echo.
echo.
echo This program runs a constant ping to Googles DNS servers every second. If it
echo detects that a ping was unsuccessful, it creates 3 log files as requested by 
echo Service Desk.
echo The files will be in a folder called FAIL, next to where this program is being
echo run from. Service Desk need those files to be able to diagnose the fault.
echo.
echo The program can be left running to collect logs. Please share any FAIL log 
echo files with Paul as soon as possible
echo Thanks, LTG IT 
timeout 1 > NUL
goto start
