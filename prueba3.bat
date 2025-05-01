@echo off
setlocal EnableDelayedExpansion

set "base_folder=C:\Users\julir\Desktop\Backup Juli"
set "min_size=524288000" REM Tamaño mínimo en bytes (500 MB)

REM Verificar si la ruta existe
if not exist "%base_folder%" (
    echo Error: La carpeta "%base_folder%" no existe.
    pause
    exit /b
)

REM Verificar que se pueden encontrar archivos mp4
echo Buscando archivos .mp4 en la carpeta "%base_folder%"
pause

REM Recorrer todos los archivos MP4 dentro de la carpeta base y subcarpetas
for /r "%base_folder%" %%F in (*.mp4) do (
    echo Procesando archivo: %%F
    REM Obtener el tamaño del archivo en bytes
    set "file_size=%%~zF"
    
    REM Mostrar tamaño del archivo para depuración
    echo Tamaño de archivo: !file_size! bytes
    pause

    REM Verificar si el tamaño del archivo es mayor a 500 MB
    if !file_size! GTR %min_size% (
        echo -----------------------------------------------
        echo Procesando archivo: "%%F"
        pause

        REM Definir ruta de salida
        set "output_video=%%~dpF%%~nF_!.mp4"
        
        REM Verificar si la ruta de salida se está generando correctamente
        echo Ruta de salida: "%%~dpF%%~nF_!.mp4"
        pause

        REM Comprimir video
        echo Ejecutando ffmpeg para comprimir: "%%F"
        pause
        ffmpeg -i "%%F" -vcodec libx264 -crf 28 "%%~dpF%%~nF_!.mp4"
        if %ERRORLEVEL% NEQ 0 (
            echo Hubo un error al procesar el video: "%%F"
            pause
            echo Omitiendo archivo...
            echo -----------------------------------------------
            goto :continue
        )

        REM Eliminar archivo original si la compresión fue exitosa
        echo Proceso completado exitosamente. Eliminando archivo original...
        pause
        del "%%F"
        if %ERRORLEVEL% NEQ 0 (
            echo Hubo un error al intentar eliminar el archivo original: "%%F"
            pause
        ) else (
            echo Archivo original eliminado con éxito.
            pause
        )
        echo -----------------------------------------------
    ) else (
        echo El archivo "%%F" no cumple con el tamaño mínimo de 500 MB.
        pause
    )
    :continue
)
echo Todos los videos mayores a 500 MB han sido procesados.
pause
endlocal