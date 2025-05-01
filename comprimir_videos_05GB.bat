@echo off
setlocal EnableDelayedExpansion

set "base_folder=F:\Backup_Gral\Backup Juli Pr"
set "min_size=524288000" REM Tamaño mínimo en bytes (500 MB)

REM Verificar si la ruta existe
if not exist "%base_folder%" (
    echo Error: La carpeta "%base_folder%" no existe.
    exit /b
)

REM Recorrer todos los archivos MP4 dentro de la carpeta base y subcarpetas
for /r "%base_folder%" %%F in (*.mp4) do (
    REM Obtener el tamaño del archivo en bytes
    set "file_size=%%~zF"

    REM Verificar si el tamaño del archivo es mayor a 500 MB
    if !file_size! GEQ %min_size% (
        REM Definir ruta de salida
        set "output_video=%%~dpF%%~nF_!.mp4"
        
        REM Comprimir video
        ffmpeg -i "%%F" -vcodec libx264 -crf 28 "!output_video!"
        
        if %ERRORLEVEL% NEQ 0 (
            echo Hubo un error al procesar el video: "%%F"
        ) else (
            echo Proceso completado exitosamente. Eliminando archivo original...
            del "%%F"
            if %ERRORLEVEL% NEQ 0 (
                echo Hubo un error al intentar eliminar el archivo original: "%%F"
            ) else (
                echo Archivo original eliminado con éxito.
            )
        )
    )
)

echo Todos los videos mayores a 500 MB han sido procesados.
endlocal