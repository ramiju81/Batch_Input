@echo off
setlocal enabledelayedexpansion

:: Define la letra de la unidad aquí (cambia "F:" por la letra que desees)
set "unidad=F:"

:: Ruta del archivo CSV de salida en el escritorio
set "outputFile=%USERPROFILE%\OneDrive\Attachments\archivos_tamanos_%unidad:~0,1%.csv"

:: Encabezado del CSV
echo Ruta Completa^|Tamaño (Bytes) > "%outputFile%"

:: Usar PowerShell para obtener todos los archivos y sus tamaños
for /f "tokens=*" %%F in ('dir "%unidad%\*" /a-d /b /s') do (
    set "file=%%F"

    :: Obtener el tamaño del archivo usando PowerShell
    for /f "tokens=*" %%S in ('powershell -Command "(Get-Item '%%F').Length"') do (
        set "sizeBytes=%%S"
    )

    :: Si no se pudo obtener el tamaño, establece el tamaño en 0
    if "!sizeBytes!"=="" set "sizeBytes=0"

    :: Escribe la información en el CSV
    echo "%%F"^|!sizeBytes! >> "%outputFile%"
)

echo Proceso completado. Los tamaños de los archivos se han guardado en %outputFile%.
pause