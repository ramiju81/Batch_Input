set video="C:\Users\julir\Desktop\Backup Actual\Mis aventuras\Anthony\2025\Anthony Priv 0101\173571828452960.mp4"
set output="C:\Users\julir\Desktop\Backup Actual\Mis aventuras\Anthony\2025\Anthony Priv 0101"

ffmpeg -i %video% -ss 0:16:47 -to 0:19:07 -c copy %output%\173571828452960_1.mp4
ffmpeg -i %video% -ss 0:21:17 -to 0:24:17 -c copy %output%\173571828452960_2.mp4
ffmpeg -i %video% -ss 0:37:25 -to 1:00:35 -c copy %output%\173571828452960_3.mp4
ffmpeg -i %video% -ss 1:01:37 -to 1:06:35 -c copy %output%\173571828452960_4.mp4
ffmpeg -i %video% -ss 1:08:37 -to 1:11:27 -c copy %output%\173571828452960_5.mp4
ffmpeg -i %video% -ss 1:13:27 -to 1:17:57 -c copy %output%\173571828452960_6.mp4
ffmpeg -i %video% -ss 1:20:37 -to 1:37:00 -c copy %output%\173571828452960_7.mp4
ffmpeg -i %video% -ss 1:45:07 -to 1:48:27 -c copy %output%\173571828452960_8.mp4
ffmpeg -i %video% -ss 1:50:47 -to 1:56:57 -c copy %output%\173571828452960_9.mp4
ffmpeg -i %video% -ss 2:00:37 -to 2:06:37 -c copy %output%\173571828452960_10.mp4
ffmpeg -i %video% -ss 2:10:07 -to 2:17:07 -c copy %output%\173571828452960_11.mp4
ffmpeg -i %video% -ss 2:26:08 -to 2:27:28 -c copy %output%\173571828452960_12.mp4
ffmpeg -i %video% -ss 2:29:28 -to 2:32:58 -c copy %output%\173571828452960_13.mp4
ffmpeg -i %video% -ss 2:36:38 -to 2:47:38 -c copy %output%\173571828452960_14.mp4
ffmpeg -i %video% -ss 2:57:48 -to 3:10:28 -c copy %output%\173571828452960_15.mp4
ffmpeg -i %video% -ss 3:13:08 -to 3:14:08 -c copy %output%\173571828452960_16.mp4
ffmpeg -i %video% -ss 3:15:08 -to 3:21:18 -c copy %output%\173571828452960_17.mp4
ffmpeg -i %video% -ss 3:22:28 -to 3:33:28 -c copy %output%\173571828452960_18.mp4
ffmpeg -i %video% -ss 3:36:18 -to 3:42:18 -c copy %output%\173571828452960_19.mp4
ffmpeg -i %video% -ss 3:50:18 -to 3:54:18 -c copy %output%\173571828452960_20.mp4
ffmpeg -i %video% -ss 3:54:18 -to 4:02:38 -c copy %output%\173571828452960_21.mp4
ffmpeg -i %video% -ss 4:07:03 -to 4:07:33 -c copy %output%\173571828452960_22.mp4
ffmpeg -i %video% -ss 4:15:03 -to 4:21:43 -c copy %output%\173571828452960_23.mp4
ffmpeg -i %video% -ss 4:30:33 -to 4:38:00 -c copy %output%\173571828452960_24.mp4
ffmpeg -i %video% -ss 4:46:13 -to 4:48:43 -c copy %output%\173571828452960_25.mp4


echo Dividido correctamente en %output%
pause