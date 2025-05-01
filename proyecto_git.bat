@echo off
chcp 65001 >nul
SETLOCAL ENABLEDELAYEDEXPANSION

REM ========== CONFIGURACIÓN ==========
SET LOG_FILE=%USERPROFILE%\Documents\log_versiones.txt


REM Proyecto 1
SET RUTA1=%UserProfile%\OneDrive\mySiss_Cloud
SET REPO1=https://github.com/juliram81/mySissCloud.git

REM Proyecto 2
SET RUTA2=%UserProfile%\OneDrive\Messungen
SET REPO2=https://github.com/juliram81/messungen.git

REM Proyecto 3
IF EXIST "G:\Mi unidad\Colab Notebooks\8IS_IW" (
    SET RUTA3=G:\Mi unidad\Colab Notebooks\8IS_IW
) ELSE (
    SET RUTA3=%UserProfile%\OneDrive\Google_Drive\Colab Notebooks
)
SET REPO3=https://github.com/juliram81/8IS-IW-JULRAM.git

REM Proyecto 4
IF EXIST "%UserProfile%\OneDrive_Unicuces\Ing Sistemas\8vo Semestre\Ingenieria web" (
    SET "RUTA4=%UserProfile%\OneDrive_Unicuces\Ing Sistemas\8vo Semestre\Ingenieria web"
) ELSE (
    SET "RUTA4=%UserProfile%\OneDrive\OneDrive_Unicuces\Ing Sistemas\8vo Semestre\Ingenieria web"
)
SET REPO4=https://github.com/juliram81/IngWewb.git

REM Proyecto 5
SET RUTA5=%UserProfile%\OneDrive\agroforest
SET REPO5=https://github.com/juliram81/agroforest.git

REM Crear log si no existe
IF NOT EXIST "%LOG_FILE%" (
    echo ==== Registro de versiones subidas a GitHub ==== > "%LOG_FILE%"
)

REM ========== PROCESO ==========
CALL :procesarProyecto "%RUTA1%" "%REPO1%"
CALL :procesarProyecto "%RUTA2%" "%REPO2%"
CALL :procesarProyecto "%RUTA3%" "%REPO3%"
CALL :procesarProyecto "%RUTA4%" "%REPO4%"
CALL :procesarProyecto "%RUTA5%" "%REPO5%"

echo Todo terminado.
pause
EXIT /B

:procesarProyecto
SET "RUTA=%~1"
SET "REPO_URL=%~2"

REM Verificar si la carpeta existe
IF NOT EXIST "!RUTA!" (
    echo La ruta "!RUTA!" no existe. Saltando...
    EXIT /B
)

REM Extraer nombre de la carpeta del proyecto
FOR %%I IN ("%RUTA%") DO SET "PROYECTO=%%~nxI"

echo -----------------------------
echo Procesando !PROYECTO! en !RUTA!...
CD /D "!RUTA!"

REM Inicializa git si no existe
IF NOT EXIST ".git" (
    git init
    git remote add origin !REPO_URL!
) ELSE (
    git remote remove origin 2>NUL
    git remote add origin !REPO_URL!
)

REM Crear README si no existe
IF NOT EXIST "README.md" (
    (
        echo # !PROYECTO!
        echo Generado automáticamente.
    ) > README.md
)

REM Verificar cambios
git add -A >nul
git diff --cached --quiet
IF !ERRORLEVEL! EQU 0 (
    echo No hay cambios en !PROYECTO!. Saltando...
    EXIT /B
)

REM Formatear fecha y hora
FOR /F "tokens=1-3 delims=/- " %%a in ("%date%") do (
    SET YY=%%c
    SET MM=%%b
    SET DD=%%a
)
FOR /F "tokens=1-3 delims=:." %%a in ("%time%") do (
    SET HH=%%a
    SET MN=%%b
    SET SS=%%c
)
IF "!HH:~0,1!"==" " SET HH=0!HH:~1,1!

SET FECHA_VER=!YY!!MM!!DD!_!HH!!MN!!SS!

git commit -m "Actualización automática !FECHA_VER!"
git push -u origin HEAD
git tag v!FECHA_VER!
git push origin v!FECHA_VER!

REM Registrar en log
echo [%date% %time%] Proyecto !PROYECTO! - Versión v!FECHA_VER! subida desde !RUTA! >> "%LOG_FILE%"

EXIT /B
