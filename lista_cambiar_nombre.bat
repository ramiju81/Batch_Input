@echo off
setlocal enabledelayedexpansion
@echo off
setlocal enabledelayedexpansion

REM Archivo con la lista de rutas
set "lista_archivos=lista_cambiar_nombre.txt"

REM Leer cada línea del archivo lista_cambiar_nombre.txt
for /f "tokens=*" %%A in (%lista_archivos%) do (
    set "archivo=%%A"

    REM Abrir la imagen con el visor predeterminado
    start "" "!archivo!"

    REM Obtener la ruta y la extensión del archivo
    for %%F in ("!archivo!") do (
        set "ruta=%%~dpF"
        set "extension=%%~xF"
    )

    REM Pedir nuevo nombre
    set /p nuevo_nombre="Digita el nombre: "

    REM Si el usuario no escribe nada, no renombrar
    if "!nuevo_nombre!"=="" (
        echo [Sin cambios] "!archivo!"
    ) else (
        ren "!archivo!" "!nuevo_nombre!!extension!"
        echo [Renombrado] "!archivo!" → "!ruta!!nuevo_nombre!!extension!"
    )

    REM Pausa entre archivos para permitir ver la imagen
    pause
)

echo Proceso completado.
pause