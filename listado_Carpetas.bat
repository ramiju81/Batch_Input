@echo off
setlocal enabledelayedexpansion

REM Definir la ruta base
set "base_folder=C:\Users\julir\Desktop\Backup Actual"

REM Definir la ruta de salida del archivo CSV
set "output_file=%USERPROFILE%\Desktop\Listado_Archivos.csv"

REM Escribir la cabecera en el archivo CSV
echo "Carpeta","Ruta Completa","Nombre Archivo","Tamaño (bytes)","Fecha de Modificación" > "%output_file%"

REM Usar DIR para listar todos los archivos
for /f "delims=" %%F in ('dir /s /b "%base_folder%"') do (
    REM Verificar si es un archivo (y no una carpeta)
    if exist "%%F" (
        set "full_path=%%F"
        set "folder_path=%%~dpF"
        set "file_name=%%~nxF"
        set "file_size=%%~zF"
        set "file_date=%%~tF"

        REM Escribir los datos en el archivo CSV
        echo "!folder_path!","!full_path!","!file_name!","!file_size!","!file_date!" >> "%output_file%"
    )
)

echo El listado de archivos se ha generado correctamente en: %output_file%
endlocal
