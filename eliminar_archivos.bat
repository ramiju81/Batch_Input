@echo off
setlocal enabledelayedexpansion

set "lista=lista_borrar_Archivo.txt"

if not exist "%lista%" (
    echo ❌ ERROR: No se encontró "%lista%".
    echo 📌 Crea un archivo "lista_borrar_Archivo.txt" con las rutas de los archivos a eliminar.
    pause
    exit /b
)

echo ----------------------------------------
echo    🗑️ ELIMINANDO ARCHIVOS DE LISTA 🗑️
echo ----------------------------------------

for /f "delims=" %%A in (%lista%) do (
    set "archivo=%%A"

    if exist "!archivo!" (
        del "!archivo!"
        if exist "!archivo!" (
            echo ❌ ERROR: No se pudo eliminar "!archivo!"
        ) else (
            echo ✅ Archivo eliminado: "!archivo!"
        )
    ) else (
        echo ⚠️ ERROR: El archivo "!archivo!" no existe.
    )
)

echo ----------------------------------------
echo      🚀 PROCESO FINALIZADO 🚀
echo ----------------------------------------
pause
