@echo off
setlocal enabledelayedexpansion

REM Definir la ruta base
set "base_folder=D:\Backup_Gral\Backup Juli"

REM Definir la ruta de salida del archivo CSV
set "output_file=%USERPROFILE%\Desktop\Listado_Seagate_Juli.csv"

REM Escribir la cabecera en el archivo CSV
echo "Consec";"Ruta Completa";"Carpeta";"Nombre Archivo";"Tipo";"Tamaño (bytes)";"Fecha de Modificación" > "%output_file%"

REM Contador para el consecutivo
set /a counter=1

REM Listar todos los archivos
for /r "%base_folder%" %%F in (*) do (
    set "full_path=%%F"
    set "folder_path=%%~dpF"
    set "file_name=%%~nxF"
    set "file_size=%%~zF"
    set "file_date=%%~tF"

    REM Extraer la extensión correcta del archivo
    set "temp_name=%%~nxF"
    set "file_ext="
    
    for /l %%A in (0,1,50) do (
        if not "!temp_name:~-%%A!"=="" (
            if "!temp_name:~-%%A,1!"=="." set "file_ext=!temp_name:~-%%A!"
        )
    )

    REM Eliminar el punto de la extensión
    set "file_ext=!file_ext:.=!"

    REM Escribir en el CSV con un número consecutivo
    echo "!counter!";"!full_path!";"!folder_path!";"!file_name!";"!file_ext!";"!file_size!";"!file_date!" >> "%output_file%"

    REM Incrementar el contador
    set /a counter+=1
)

echo El listado de archivos y carpetas se ha generado correctamente en: %output_file%
endlocal
