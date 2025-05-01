@echo on
setlocal enabledelayedexpansion

REM Archivo con la lista de rutas
set "archivo_lista=lista_cambiar_nombre.txt"
set "debug_log=debug.log"
set "error_log=error.log"

REM Limpiar logs previos
echo === INICIO DEL SCRIPT === > "%debug_log%"
echo === ERRORES === > "%error_log%"

REM Verificar si el archivo de lista existe
if not exist "%archivo_lista%" (
    echo ❌ ERROR: No se encuentra "%archivo_lista%". >> "%error_log%"
    echo ❌ ERROR: No se encuentra "%archivo_lista%". 
    exit /b
)

echo 📄 Archivo a leer: "%archivo_lista%" >> "%debug_log%"

REM Leer cada línea del archivo
for /f "usebackq delims=" %%A in ("%archivo_lista%") do (
    echo 🔍 Línea leída: "%%A"
pause
)
for /f "usebackq delims=" %%A in ("%archivo_lista%") do (
    set "ruta_original=%%A"

    REM Verificar si el archivo existe
    if not exist "!ruta_original!" (
        echo ❌ No encontrado: "!ruta_original!" >> "%error_log%"
        echo ❌ No encontrado: "!ruta_original!"
        goto :continue
    )

    REM Obtener directorio y nombre del archivo
    for %%F in ("!ruta_original!") do (
        set "directorio=%%~dpF"
        set "nombre_completo=%%~nxF"
        set "extension=%%~xF"
    )

    echo 🔍 Procesando: "!ruta_original!" >> "%debug_log%"

    REM Truncar nombre a 30 caracteres (sin extensión)
    set "nuevo_nombre=!nombre_completo:~0,30!!extension!"

    REM Si el nombre ya existe, agregar un número
    set "contador=1"
    :verificar_nombre
    if exist "!directorio!!nuevo_nombre!" (
        set /a contador+=1
        set "nuevo_nombre=!nombre_completo:~0,27!_!contador!!extension!"
        goto verificar_nombre
    )

    REM Renombrar archivo
    ren "!ruta_original!" "!nuevo_nombre!"
    
    REM Confirmación
    if exist "!directorio!!nuevo_nombre!" (
   
