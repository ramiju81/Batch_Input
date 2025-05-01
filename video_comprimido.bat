@echo off
Title Copia de Seguridad
echo              =========================================
echo              =                                       =
echo              =         Copia de Seguridad            =
echo              =                                       =
echo              =========================================
echo.
echo  video comprimido
set "input_video=C:\Users\julir\Desktop\Backup Juli\VID_20240831_152051758.mp4"
set "output_video=C:\Users\julir\Desktop\Backup Juli\VID_20240831_152051758_1.mp4"

echo Procesando video...
ffmpeg -i "%input_video%" -vcodec libx264 -crf 28 "%output_video%"
if %ERRORLEVEL% NEQ 0 (
    echo Hubo un error al procesar el video. No se eliminará el archivo original.
    pause
    exit /b
)

echo Proceso completado exitosamente.
echo Eliminando archivo original...
del "%input_video%"
if %ERRORLEVEL% NEQ 0 (
    echo Hubo un error al intentar eliminar el archivo original.
    pause
    exit /b
)

echo Archivo original eliminado con éxito.
pause