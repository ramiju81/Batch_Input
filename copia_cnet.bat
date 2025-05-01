@echo off
REM Configuración de las rutas
set ORIGEN=C:\Users\ramiju\Downloads\Julian
set DESTINO=\\cncd\privada\Proyectos MySiss\00. Producto\Inventario ABAP

REM Verificar si la carpeta destino existe; si no, crearla
if not exist "%DESTINO%" (
    echo Creando carpeta destino...
    mkdir "%DESTINO%"
)

REM Copiar los archivos, actualizándolos si ya existen
echo Copiando archivos...
xcopy "%ORIGEN%\*" "%DESTINO%" /e /h /y /c

REM Mostrar mensaje de finalización
echo Archivos copiados correctamente.
pause