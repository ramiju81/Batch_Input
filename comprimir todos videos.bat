@echo off
Title Copia de Seguridad
echo              =========================================
echo              =                                       =
echo              =         Copia de Seguridad            =
echo              =                                       =
echo              =========================================
echo.
set "base_folder=F:\Backup_Gral"
set "min_size=1073741824" REM Tamaño mínimo en bytes (1 GB)

echo Procesando videos mayores a 1 GB en: %base_folder%

REM Recorrer todos los archivos MP4 dentro de la carpeta base y subcarpetas
for /r "%base_folder%" %%F in (*.mp4) do (
    REM Obtener el tamaño del archivo en bytes
    forfiles /p "%%~dpF" /m "%%~nxF" /c "cmd /c if @fsize GTR %min_size% echo %%~fF" >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo -----------------------------------------------
        echo Procesando archivo: %%F

        REM Definir ruta de salida
        set "output_video=%%~dpF%%~nF_!.mp4"

        REM Comprimir video
        ffmpeg -i "%%F" -vcodec libx264 -crf 28 "%%~dpF%%~nF_!.mp4"
        if %ERRORLEVEL% NEQ 0 (
            echo Hubo un error al procesar el video: %%F
            echo Omitiendo archivo...
            echo -----------------------------------------------
            pause
            goto :continue
        )

        REM Eliminar archivo original si la compresión fue exitosa
        echo Proceso completado exitosamente. Eliminando archivo original...
        del "%%F"
        if %ERRORLEVEL% NEQ 0 (
            echo Hubo un error al intentar eliminar el archivo original: %%F
        ) else (
            echo Archivo original eliminado con éxito.
        )
        echo -----------------------------------------------
    )
    :continue
)
echo Todos los videos mayores a 1 GB han sido procesados.
pause