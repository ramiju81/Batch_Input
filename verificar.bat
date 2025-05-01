@echo off
setlocal enabledelayedexpansion

REM Obtener ruta del archivo de lista
set "archivo_lista=%CD%\lista_cambiar_nombre.txt"

REM Verificar si el archivo existe
if not exist "%archivo_lista%" (
    echo ❌ Error: No se encontró "%archivo_lista%". Asegúrate de que está en la misma carpeta.
    pause
    exit /b
)

echo 📄 Archivo a leer: "%archivo_lista%"
echo 📄 Archivo a leer: "%archivo_lista%" > debug.log

REM Leer cada línea y corregir caracteres
for /f "usebackq tokens=*" %%A in ("%archivo_lista%") do (
    set "ruta_original=%%A"
    echo 🔍 Leyendo: "!ruta_original!"
    echo 🔍 Leyendo: "!ruta_original!" >> debug.log
)

echo 🔥 Revisa "debug.log" para confirmar la lectura correcta.
pause
exit /b
