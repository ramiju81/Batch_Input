@echo off
Title Copia de Seguridad
echo              =========================================
echo              =                                       =
echo              =         Copia de Seguridad            =
echo              =                                       =
echo              =========================================
echo.
echo  Haciendo carpetas
xcopy F:\ D:\ /t /e /i /y

ffmpeg -i C:\Users\julir\Desktop\Prueba\icam365Record20250223011412717 -vcodec libx264 -crf 28 C:\Users\julir\Desktop\Prueba\icam365Record20250223011412717_pr