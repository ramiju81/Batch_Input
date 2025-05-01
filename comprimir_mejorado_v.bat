 @echo off
setlocal EnableDelayedExpansion

REM Solicitar la carpeta base
set /p "base_folder=Ingrese la carpeta donde desea realizar el proceso: "
if not exist "%base_folder%" (
    echo Error: La carpeta "%base_folder%" no existe.
    exit /b
)

REM Selección de tamaño
echo Seleccione el peso de los archivos a procesar:
echo 1. Menores a 500 MB
echo 2. Entre 500 MB a 1 GB
echo 3. Entre 1 GB a 2 GB
echo 4. Mayores a 2 GB
set /p "size_option=Seleccione una (1-4): "

if "%size_option%"=="1" (
    set "min_size=0"
    set "max_size=524288000"
) else if "%size_option%"=="2" (
    set "min_size=524288000"
    set "max_size=1073741824"
) else if "%size_option%"=="3" (
    set "min_size=1073741824"
    set "max_size=2147483648"
) else if "%size_option%"=="4" (
    set "min_size=2147483649"
    set "max_size=9999999999"
) else (
    echo Opción no válida. Saliendo...
    exit /b
)

REM Crear carpeta de logs en el escritorio
set "log_folder=%USERPROFILE%\Desktop\log"
if not exist "%log_folder%" mkdir "%log_folder%"

REM Crear archivo log con fecha y hora
for /f "tokens=1-3 delims=/ " %%a in ("%DATE%") do set "fecha=%%c-%%b-%%a"
set "hora=%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%"
set "log_file=%log_folder%\log_%fecha%_%hora%.txt"

REM Recorrer archivos MP4
for /r "%base_folder%" %%F in (*.mp4) do (
    set "file_size=%%~zF"

    if !file_size! GEQ %min_size% if !file_size! LEQ %max_size% (
        set "output_video=%%~dpF%%~nF_.mp4"

        REM Comprimir con FFmpeg usando preset veryfast para mayor velocidad
        echo Procesando: %%F >> "%log_file%"
        ffmpeg -i "%%F" -vcodec libx264 -crf 28 -preset veryfast "!output_video!" -y

        REM Verificar si el archivo comprimido se generó
        if exist "!output_video!" (
            for %%X in ("!output_video!") do set "new_size=%%~zX"
            echo Original: %%F - Tamaño: !file_size! bytes >> "%log_file%"
            echo Comprimido: !output_video! - Tamaño: !new_size! bytes >> "%log_file%"

            REM Si la compresión fue exitosa, reemplazar el archivo original
            del "%%F"
            rename "!output_video!" "%%~nxF"
        ) else (
            echo Error al comprimir: %%F >> "%log_file%"
        )
    )
)

echo Procesamiento finalizado. Log en: %log_file%
endlocal
