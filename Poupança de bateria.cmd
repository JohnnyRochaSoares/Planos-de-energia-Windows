@echo off

:: Auto-admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit
)

echo Ativar MODO ECO + 60Hz...

:: Plano de energia eficiente
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

:: CPU baixo consumo
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 5
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMAX 5

powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 5
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMIN 5

:: Turbo OFF
powercfg /setacvalueindex scheme_current sub_processor PERFBOOSTMODE 0
powercfg /setdcvalueindex scheme_current sub_processor PERFBOOSTMODE 0

:: Suspensão rápida (eco)
powercfg /change standby-timeout-ac 1
powercfg /change standby-timeout-dc 1

:: Ecrã rápido
powercfg /change monitor-timeout-ac 1
powercfg /change monitor-timeout-dc 1

:: Ativar economia de bateria do Windows
powercfg /setdcvalueindex scheme_current sub_battery BATACTIONCRIT 1

:: Tentar forçar plano de energia gráfico (eco GPU)
powercfg /setactive scheme_current

echo.
echo IMPORTANTE:
echo Vai agora abrir definicoes de ecrã para mudares para 60Hz.

start ms-settings:display-advanced

echo MODO ECO ATIVADO.
pause