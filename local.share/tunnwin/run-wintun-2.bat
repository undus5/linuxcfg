REM wintun batch

route delete 0.0.0.0
netsh interface ip set address wintun static 172.31.32.33 255.255.255.0 none
timeout /nobreak /t 5
route add 0.0.0.0 mask 0.0.0.0 172.31.32.33

