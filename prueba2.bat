@echo off
setlocal EnableDelayedExpansion

set "base_folder=C:\Users\julir\Desktop\Backup Juli"
set "min_size=524288000" REM Tamaño mínimo en bytes (500 MB)

REM Verificar si la ruta existe
echo Verificando si la ruta "%base_folder%" existe...
if not exist "%base_folder%" (
    echo Error: La carpeta "%base_folder%" no existe.
    pause
    exit /b
)

echo Procesando videos mayores a 500 MB en: "%base_folder%"
pause

REM Recorrer todos los archivos MP4 dentro de la carpeta base y subcarpetas
for /r "%base_folder%" %%F in (*.mp4) do (
    echo Procesando archivo: "%%F"
    
    REM Obtener el tamaño del archivo en bytes
    set "file_size=%%~zF"
    
    REM Mostrar tamaño del archivo para depuración
    echo Tamaño de archivo: !file_size! bytes
    pause

    REM Verificar si el tamaño del archivo es mayor a 500 MB
    if !file_size! GEQ %min_size% (
        echo -----------------------------------------------
        echo Procesando archivo: "%%F"
        pause

        REM Definir ruta de salida
        set "output_video=%%~dpF%%~nF_!.mp4"
        
        REM Comprimir video
        echo Ejecutando ffmpeg para comprimir: "%%F"
        ffmpeg -i "%%F" -vcodec libx264 -crf 28 "!output_video!"
        
        if %ERRORLEVEL% NEQ 0 (
            echo Hubo un error al procesar el video: "%%F"
            pause
        ) else (
            echo Proceso completado exitosamente. Eliminando archivo original...
            del "%%F"
            if %ERRORLEVEL% NEQ 0 (
                echo Hubo un error al intentar eliminar el archivo original: "%%F"
                pause
            ) else (
                echo Archivo original eliminado con éxito.
            )
        )
        echo -----------------------------------------------
    ) else (
        echo El archivo "%%F" no cumple con el tamaño mínimo de 500 MB.
        pause
    )
)

echo Todos los videos mayores a 500 MB han sido procesados.
pause
endlocal