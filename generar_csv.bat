@echo off
setlocal enabledelayedexpansion

REM Definir la ruta base
set "base_folder=C:\Users\julir\Desktop\Backup Actual"

REM Definir la ruta de salida del archivo CSV
set "output_file=%USERPROFILE%\Desktop\Listado_Archivos_pr.csv"

REM Escribir la cabecera en el archivo CSV
echo "Carpeta","Ruta Completa","Nombre Archivo","Extensión","Tamaño (bytes)","Fecha de Modificación","Tipo","Nombre Limpio","Número en Paréntesis" > "%output_file%"

REM Listar todos los archivos
for /r "%base_folder%" %%F in (*) do (
    set "full_path=%%F"
    set "folder_path=%%~dpF"
    set "file_name=%%~nxF"
    set "file_ext=%%~xF"
    set "file_size=%%~zF"
    set "file_date=%%~tF"
    set "file_type=Archivo"
    
    REM Extraer el número en paréntesis si existe y limpiar el nombre del archivo
    set "file_name_clean=!file_name!"
    set "file_number="
    
    for %%A in (!file_name!) do (
        set "file_name_clean=%%~nA"
        set "file_ext=%%~xA"
    )
    
    echo !file_name_clean! | findstr /r "(.*)" >nul && (
        for /f "tokens=1,2 delims=()" %%B in ("!file_name!") do (
            set "file_name_clean=%%B"
            set "file_number=%%C"
        )
    )
    
    REM Asegurar que el nombre limpio conserva la extensión
    set "file_name_clean=!file_name_clean!!file_ext!"
    
    REM Escribir en el CSV
    echo "!folder_path!","!full_path!","!file_name!","!file_ext!","!file_size!","!file_date!","!file_type!","!file_name_clean!","!file_number!" >> "%output_file%"
)

echo El listado de archivos y carpetas se ha generado correctamente en: %output_file%
endlocal