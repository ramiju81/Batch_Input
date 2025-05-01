@echo off
if not exist G:\ (
    echo La unidad G: no está conectada. Cerrando script.
    exit /b
)

echo Copiando archivos del GoogleDrive a Backup...


ROBOCOPY "G:\Mi unidad" "C:\Users\julir\OneDrive\Google_Drive" /S /E /DCOPY:DA /COPY:DAT /XO /XN /R:3 /W:5 /XF *.gdoc *.gsheet *.gform /LOG:"C:\Users\julir\OneDrive\Google_Drive\logs\sync_log_GDrive.txt"

echo Copia completada.
pause
