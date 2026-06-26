@echo off

:: Auto-admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit
)

echo A Ativar o Modo Eco...

:: Plano de energia eficiente
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

:: CPU minimo - zero permite descer ao minimo absoluto quando idle
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 0
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMIN 0

:: CPU maximo
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 5
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMAX 5

:: Turbo OFF
powercfg /setacvalueindex scheme_current sub_processor PERFBOOSTMODE 0
powercfg /setdcvalueindex scheme_current sub_processor PERFBOOSTMODE 0

:: Suspensao rapida
powercfg /change standby-timeout-ac 5
powercfg /change standby-timeout-dc 1

:: Ecra rapido
powercfg /change monitor-timeout-ac 3
powercfg /change monitor-timeout-dc 1

:: Acao em bateria critica
powercfg /setdcvalueindex scheme_current sub_battery BATACTIONCRIT 1

:: Aplicar alteracoes
powercfg /setactive scheme_current

echo.
echo IMPORTANTE:
echo Vai agora abrir definicoes de ecra para mudares para 60Hz.

start ms-settings:display-advanced

echo Modo Eco Ativado.
pause