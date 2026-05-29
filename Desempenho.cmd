@echo off

:: Verificar admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo A reiniciar como administrador...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit
)

echo Ativar MODO DESEMPENHO MAXIMO...

:: Plano de energia alto desempenho
powercfg /setactive SCHEME_MIN

:: CPU mínimo 100% (nunca baixa)
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100

:: CPU máximo 100%
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100
powercfg /setdcvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100

:: Turbo boost ON
powercfg /setacvalueindex scheme_current sub_processor PERFBOOSTMODE 2
powercfg /setdcvalueindex scheme_current sub_processor PERFBOOSTMODE 2

:: Suspensão mais tardia (para não interromper trabalho/jogos)
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 10

:: Ecrã mais relaxado
powercfg /change monitor-timeout-ac 10
powercfg /change monitor-timeout-dc 5

:: Hibernação ligada (segurança)
powercfg /hibernate on

start ms-settings:display-advanced

echo MODO DESEMPENHO ATIVADO.
pause
