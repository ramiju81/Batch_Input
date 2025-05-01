@echo off
Title Copia de Seguridad
echo              =========================================
echo              =                                       =
echo              =         Copia de Seguridad            =
echo              =                                       =
echo              =========================================
echo.
echo  Haciendo un respaldo imagenes
xcopy C:\Users\ramiju\Pictures \\192.168.0.104\Backup_gral\CNET\Pictures /s /c /d /e /h /i /r /k /y

echo  Haciendo un respaldo mis documentos en red
xcopy C:"\Users\ramiju\OneDrive - COMPUNET\Escritorio\Mis Documentos" \\192.168.0.104\Backup_gral\CNET\Mis Documentos /s /c /d /e /h /i /r /k /y

echo  Haciendo un respaldo proyectos
xcopy C:"\Users\ramiju\OneDrive - COMPUNET\Escritorio\Proyectos" \\192.168.0.104\Backup_gral\CNET\Proyectos /s /c /d /e /h /i /r /k /y

echo  Haciendo un respaldo videos
xcopy C:\Users\ramiju\Videos \\192.168.0.104\Backup_gral\CNET\Videos /s /c /d /e /h /i /r /k /y

echo  Haciendo un respaldo descargas
xcopy C:\Users\ramiju\Downloads \\192.168.0.104\Backup_gral\CNET\Downloads  /s /c /d /e /h /i /r /k /y

echo  Haciendo un respaldo documentos
xcopy C:\Users\ramiju\Documents \\192.168.0.104\Backup_gral\CNET\\Documents /s /c /d /e /h /i /r /k /y


