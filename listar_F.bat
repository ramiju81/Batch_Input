@echo off
setlocal enabledelayedexpansion

REM Definir la ruta base
set "base_folder=F:"

REM Definir la ruta de salida del archivo CSV
set "output_file=%USERPROFILE%\Desktop\Listado_Archivos_F.csv"

REM Escribir la cabecera en el archivo CSV
echo "Carpeta","Ruta Completa","Nombre Archivo","Tamaño (bytes)","Fecha de Modificación","Tipo" > "%output_file%"


REM Listar todos los archivos
for /r "%base_folder%" %%F in (*) do (
    set "full_path=%%F"
    set "folder_path=%%~dpF"
    set "file_name=%%~nxF"
    set "file_size=%%~zF"
    set "file_date=%%~tF"
    set "file_type=Archivo"

    REM Escribir en el CSV
    echo "!folder_path!","!full_path!","!file_name!","!file_size!","!file_date!","!file_type!" >> "%output_file%"
)

echo El listado de archivos y carpetas se ha generado correctamente en: %output_file%
endlocal
