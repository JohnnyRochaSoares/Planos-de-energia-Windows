@echo off

:: Auto-admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit
)

echo A Ativar o Modo Medio...

:: Plano Balanced
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e

:: CPU minimo
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 5
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMIN 0

:: CPU maximo
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMAX 60

:: Turbo boost
powercfg /setacvalueindex scheme_current sub_processor PERFBOOSTMODE 1
powercfg /setdcvalueindex scheme_current sub_processor PERFBOOSTMODE 0

:: Suspensao
powercfg /change standby-timeout-ac 15
powercfg /change standby-timeout-dc 2

:: Ecra
powercfg /change monitor-timeout-ac 8
powercfg /change monitor-timeout-dc 2

:: Aplicar alteracoes
powercfg /setactive scheme_current

start ms-settings:display-advanced

echo Modo Medio Ativado.
pause