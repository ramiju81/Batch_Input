@echo off
setlocal enabledelayedexpansion

echo Buscando archivos con tamaño 0 en F:...
echo. > "F:\archivos_vacios.txt"

for /r F:\ %%f in (*) do (
    if %%~zf equ 0 (
        echo %%f >> "F:\archivos_vacios.txt"
    )
)

echo Lista de archivos vacios generada en: F:\archivos_vacios.txt
pause