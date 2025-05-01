@echo off
Title Copia de Seguridad
echo              =========================================
echo              =                                       =
echo              =         Copia de Seguridad            =
echo              =                                       =
echo              =========================================
echo.
echo  video comprimido
ffmpeg -i C:\Users\julir\Desktop\1\VID_20240831_152051758.mp4 -vcodec libx264 -crf 28 C:\Users\julir\Desktop\1\VID_20240831_152051758_C.mp4
if %ERRORLEVEL% NEQ 0 (
    echo Hubo un error al procesar el video.
    pause
) else (
    echo Proceso completado exitosamente.
    pause
)