@echo off
setlocal EnableDelayedExpansion

REM Solicitar al usuario la carpeta base donde se realizará el proceso
set /p "base_folder=Ingrese la carpeta donde desea realizar el proceso: "
if not exist "%base_folder%" (
    echo Error: La carpeta "%base_folder%" no existe.
    exit /b
)

REM Solicitar al usuario el peso de archivo a procesar
echo Seleccione el peso de los archivos a procesar:
echo 1. Menores a 500 MB
echo 2. Entre 500 MB a 1 GB
echo 3. Entre 1 GB a 2 GB
echo 4. Mayores a 2 GB
set /p "size_option=Seleccione una (1-4): "

REM Definir el tamaño mínimo y máximo en bytes según la opción seleccionada
if "%size_option%"=="1" (
    set "min_size=0"
    set "max_size=524288000" REM 500 MB en bytes
) else if "%size_option%"=="2" (
    set "min_size=524288000" REM 500 MB en bytes
    set "max_size=1073741824" REM 1 GB en bytes
) else if "%size_option%"=="3" (
    set "min_size=1073741824" REM 1 GB en bytes
    set "max_size=2147483648" REM 2 GB en bytes
) else if "%size_option%"=="4" (
    set "min_size=2147483649" REM Mayor a 2 GB
    set "max_size=9999999999" REM Un valor muy grande para archivos mayores a 2 GB
) else (
    echo Opción no válida. Saliendo del script...
    exit /b
)

REM Crear la carpeta log en el escritorio si no existe
set "log_folder=%USERPROFILE%\Desktop\log"
if not exist "%log_folder%" (
    mkdir "%log_folder%"
)

REM Crear archivo log con fecha y hora
set "log_file=%log_folder%\log_%DATE%_%TIME%.txt"
set "log_file=%log_file::=-%"
set "log_file=%log_file:/=-%"
set "log_file=%log_file: =_%"

REM Recorrer todos los archivos MP4 dentro de la carpeta base y subcarpetas
for /r "%base_folder%" %%F in (*.mp4) do (
    REM Obtener el tamaño del archivo en bytes antes de comprimir
    set "file_size=%%~zF"

    REM Verificar si el tamaño del archivo está dentro del rango seleccionado
    if !file_size! GEQ %min_size% if !file_size! LEQ %max_size% (
        REM Definir ruta de salida
        set "output_video=%%~dpF%%~nF_.mp4"

        REM Comprimir video con calidad optimizada
        ffmpeg -i "%%F" -vcodec libx264 -crf 23 -preset slow "!output_video!" -y

        if exist "!output_video!" (
            set "new_size=!output_video:~z!"
            echo Archivo original: %%F - Tamaño: !file_size! bytes >> "%log_file%"
            echo Archivo comprimido: !output_video! - Tamaño: !new_size! bytes >> "%log_file%"

            REM Si la compresión fue exitosa, eliminar el original
            del "%%F"
            rename "!output_video!" "%%~nxF"
        ) else (
            echo Error al comprimir el archivo: %%F >> "%log_file%"
        )
    )
)

echo Todos los videos dentro del rango seleccionado han sido procesados. >> "%log_file%"
echo El log se ha guardado en: %log_file%

endlocal
