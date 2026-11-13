@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"
title 心理老师工作台 - 本地服务

set "URL=http://localhost:8000/index.html"

echo.
echo   心理老师工作台
echo   ------------------------------------------
echo.

REM 1) 8000 上已经是本项目的服务（能读到 app.js）就只开页面
curl -s --noproxy "*" --max-time 2 "http://localhost:8000/app.js" | findstr /C:"psy_workbench_v1" >nul
if not errorlevel 1 goto OPEN

REM 2) 端口被别的目录占用时，只停掉 python 静态服务，不碰其它程序
for /f "tokens=5" %%P in ('netstat -ano ^| findstr /C:":8000 " ^| findstr /C:"LISTENING"') do (
  set "PNAME="
  for /f "tokens=1" %%N in ('tasklist /FI "PID eq %%P" /NH 2^>nul') do set "PNAME=%%N"
  if /I "!PNAME!"=="python.exe" taskkill /PID %%P /F >nul 2>&1
)

REM 3) 延时 3 秒自动开浏览器，然后就在本窗口前台跑服务（关窗口 = 关服务）
start "WB_OPENER" /MIN cmd /c "ping -n 4 127.0.0.1 >nul & start %URL%"
echo   本地服务正在本窗口启动。
echo   访问地址： %URL%
echo   浏览器会在 3 秒后自动打开；若没弹出，手动打开上面地址即可。
echo.
echo   使用期间请保持本窗口打开，关闭本窗口即停止服务。
echo.
python -m http.server 8000 --bind 127.0.0.1
echo.
echo   服务已停止。按任意键关闭本窗口。
pause >nul
exit /b 0

:OPEN
echo   服务已在运行，正在打开页面。
start "" "%URL%"
exit /b 0
