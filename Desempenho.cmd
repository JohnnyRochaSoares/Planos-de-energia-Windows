@echo off

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo A reiniciar como administrador...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit
)

echo A Ativar o Modo Desempenho...

:: Ativar e selecionar o plano Maximo Desempenho (Ultimate Performance)
powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
for /f "tokens=4" %%G in ('powercfg /list ^| findstr /i "Ultimate\|Maximo\|e9a42b02"') do (
    powercfg /setactive %%G
)

:: CPU minimo
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 99
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMIN 99

:: CPU maximo
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100

:: Turbo boost agressivo
powercfg /setacvalueindex scheme_current sub_processor PERFBOOSTMODE 2
powercfg /setdcvalueindex scheme_current sub_processor PERFBOOSTMODE 2

:: Sem suspensao em corrente
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0

:: Ecra
powercfg /change monitor-timeout-ac 5
powercfg /change monitor-timeout-dc 0

:: Hibernacao
powercfg /hibernate on

:: Aplicar alteracoes
powercfg /setactive scheme_current

start ms-settings:display-advanced

echo Modo Desempenho Ativado.
pause