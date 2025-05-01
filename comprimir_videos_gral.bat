@echo off
setlocal EnableDelayedExpansion

REM Solicitar al usuario la carpeta base donde se realizará el proceso
set /p "base_folder=Ingrese la carpeta donde desea realizar el proceso: "
if not exist "%base_folder%" (
    echo Error: La carpeta "%base_folder%" no existe.
    exit /b
)

REM Solicitar al usuario el tamaño de archivo a procesar
echo Seleccione el tamaño de los archivos a procesar:
echo 1. Menores a 0.5 GB
echo 2. Menores a 1 GB
echo 3. Menores a 2 GB
echo 4. Mayores a 2 GB
set /p "size_option=Seleccione una opción (1-4): "

REM Definir el tamaño mínimo en bytes según la opción seleccionada
if "%size_option%"=="1" (
    set "min_size=524288000" REM 0.5 GB en bytes
) else if "%size_option%"=="2" (
    set "min_size=1073741824" REM 1 GB en bytes
) else if "%size_option%"=="3" (
    set "min_size=2147483648" REM 2 GB en bytes
) else if "%size_option%"=="4" (
    set "min_size=2147483649" REM Mayor a 2 GB
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
    REM Obtener el tamaño del archivo en bytes
    set "file_size=%%~zF"

    REM Verificar si el tamaño del archivo es mayor al mínimo especificado
    if !file_size! GEQ %min_size% (
        REM Definir ruta de salida
        set "output_video=%%~dpF%%~nF_!.mp4"
        
        REM Comprimir video
        ffmpeg -i "%%F" -vcodec libx264 -crf 28 "!output_video!"
        
        if %ERRORLEVEL% NEQ 0 (
            echo Hubo un error al procesar el video: "%%F" >> "%log_file%"
        ) else (
            echo Proceso completado exitosamente. Eliminando archivo original... >> "%log_file%"
            del "%%F"
            if %ERRORLEVEL% NEQ 0 (
                echo Hubo un error al intentar eliminar el archivo original: "%%F" >> "%log_file%"
            ) else (
                echo Archivo original eliminado con éxito. >> "%log_file%"
            )
        )
    )
)

echo Todos los videos mayores al tamaño seleccionado han sido procesados. >> "%log_file%"
echo El log se ha guardado en: %log_file%

endlocal
