@echo off
setlocal enabledelayedexpansion

:: Define la letra de la unidad aquí (cambia "F:" por la letra que desees)
set "unidad=F:"

:: Ruta del archivo CSV de salida en el escritorio
set "outputFile=%USERPROFILE%\OneDrive\Attachments\carpetas_tamanos_%unidad:~0,1%.csv"

:: Encabezado del CSV
echo Carpeta,Tamaño (Bytes) > "%outputFile%"

:: Usar PowerShell para calcular el tamaño de todas las carpetas y subcarpetas
for /f "tokens=*" %%D in ('dir "%unidad%\*" /ad /b /s') do (
    set "folder=%%D"

    :: Calcular el tamaño de la carpeta usando PowerShell
    for /f "tokens=*" %%S in ('powershell -Command "Get-ChildItem -Path '%%D' -Recurse -File | Measure-Object -Property Length -Sum | Select-Object -ExpandProperty Sum"') do (
        set "sizeBytes=%%S"
    )

    :: Si no se pudo calcular el tamaño, establece el tamaño en 0
    if "!sizeBytes!"=="" set "sizeBytes=0"

    :: Escribe la información en el CSV
    echo "%%D",!sizeBytes! >> "%outputFile%"
)

echo Proceso completado. Los tamaños de las carpetas se han guardado en %outputFile%.
pause