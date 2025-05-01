@echo off
setlocal enabledelayedexpansion

:: Configuración
set "disco=F:\NUBE\box" :: Cambia a tu letra de disco
set "reporte=%USERPROFILE%\Desktop\Duplicados_box.csv"  :: Reporte en el escritorio


echo. > "%reporte%"  :: Crear archivo vacío (o sobrescribir si existe)

:: --- PASO 1: Listar TODOS los archivos con sus tamaños ---
echo Buscando archivos en %disco% (paciencia, mi vida...) & echo.
set "temp_lista=%temp%\lista_archivosB.txt"
dir /s /b /a-d "%disco%" > "%temp_lista%"

:: --- PASO 2: Procesar y agrupar duplicados ---
set "consec=1"
echo Consec^|Archivo 1^|Archivo 2^|Archivo 3^|Archivo 4^|Archivo 5^|TamañoBytes >> "%reporte%"

for /f "tokens=*" %%a in ('type "%temp_lista%"') do (
    set "archivo_actual=%%a"
    set "nombre_actual=%%~nxa"
    :: Limpiar sufijos (1), (2), etc.
    set "nombre_limpio=!nombre_actual: (^)=!"
    set "nombre_limpio=!nombre_limpio:(^)=!"

    :: Si no se ha procesado este archivo...
    if not defined procesado[!nombre_limpio!] (
        set "procesado[!nombre_limpio!]=1"
        :: Buscar coincidencias por nombre limpio y tamaño
        set "lista_duplicados="
        set "tamano_archivo=%%~za"
        
        for /f "tokens=*" %%b in ('type "%temp_lista%" ^| find "!nombre_actual!"') do (
            set "archivo_candidato=%%b"
            set "nombre_candidato=%%~nxb"
            :: Verificar si el nombre base coincide (ignorando (1), (2))
            set "nombre_candidato_limpio=!nombre_candidato: (^)=!"
            set "nombre_candidato_limpio=!nombre_candidato_limpio:(^)=!"
            
            if "!nombre_candidato_limpio!"=="!nombre_limpio!" (
                set "lista_duplicados=!lista_duplicados!^|%%b"
            )
        )
        
        :: Contar cuántos duplicados hay
        set "contador=0"
        for %%d in (!lista_duplicados!) do set /a "contador+=1"
        
        :: Si hay más de 1, guardar en reporte
        if !contador! gtr 1 (
            echo !consec!!lista_duplicados!^|!tamano_archivo! >> "%reporte%"
            set /a "consec+=1"
        )
    )
)

:: --- FIN ---
del "%temp_lista%"
echo. & echo Reporte generado en: "%reporte%"
start "" "%reporte%"
pause  :: Para que veas los mensajes antes de cerrar