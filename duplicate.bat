@echo off
set "folder=F:"  ¡Cambia esto por tu ruta real!
set "output=duplicates.txt"
set "desktop=%USERPROFILE%\Desktop\%output%"

:: Paso 1: Listar todos los archivos en el backup
dir /s /b "%folder%\*" > files.txt

:: Paso 2: Buscar duplicados (mismo nombre y tamaño)
for /f "delims=" %%a in (files.txt) do (
  echo Verificando: %%~nxa
  for /f "delims=" %%b in ('findstr /i /c:"%%~nxa" files.txt ^| findstr /i /c:"%%~za"') do (
    echo Duplicado: %%a -- %%b >> %output%
    echo --------------------------------- >> %output%
    echo DUPLICADO ENCONTRADO:            >> %output%
    echo Archivo 1: %%a                   >> %output%
    echo Archivo 2: %%b                   >> %output%
    echo Tamaño: %%~za bytes              >> %output%
    echo --------------------------------- >> %output%
  )
)

:: Paso 3: Copiar el resultado al escritorio y limpiar archivos temporales
if exist "%output%" (
  copy "%output%" "%desktop%" >nul
  del files.txt
  echo ¡Listo! Revisa el archivo "%output%" en tu escritorio.
) else (
  echo No se encontraron archivos duplicados.
  del files.txt
)