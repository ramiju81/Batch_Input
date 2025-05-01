@echo off
setlocal enabledelayedexpansion

:: Pedir al usuario la carpeta a revisar
set /p "folder=Introduce la ruta de la carpeta donde buscar los videos: "

:: Verifica si la carpeta existe
if not exist "%folder%" (
    echo La carpeta especificada no existe. Saliendo...
    pause
    exit /b
)

:: Pedir al usuario la palabra a cambiar
set /p "oldWord=Introduce la palabra que deseas reemplazar: "

:: Pedir al usuario la palabra con la que reemplazar
set /p "newWord=Introduce la nueva palabra para reemplazar o deja vacio para eliminar: "

:: Si la nueva palabra está vacía, solo la eliminamos
if "%newWord%"=="" set "newWord="

:: Recorre todos los archivos .mp4 en la carpeta dada y sus subcarpetas
echo Recorriendo los archivos en la carpeta "%folder%"...
for /r "%folder%" %%F in (*.mp4) do (
    set "oldName=%%~nxF"
    
    echo Revisando archivo: %%F
    echo Nombre actual: !oldName!
    
    :: Realiza el reemplazo de la palabra
    set "newName=!oldName:%oldWord%=%newWord%!"
    
    :: Verifica si el nombre ha cambiado
    if not "!oldName!"=="!newName!" (
        echo Renombrando: "%%F" -> "!newName!"
        ren "%%F" "!newName!"
        
        :: Verifica que el archivo sigue funcionando
        if exist "%%~dpF!newName!" (
            echo El archivo se renombró correctamente.
        ) else (
            echo Error al renombrar el archivo, verificando que funcione...
        )
    ) else (
        echo No se realizó ningún cambio en: %%F
    )
)

echo Proceso finalizado.
pause
