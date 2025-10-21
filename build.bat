@echo off

del mod.iwd
powershell -Command "Compress-Archive -Force -Path mp,ui_mp,ui,scripts,maps,images -DestinationPath mod.zip; Rename-Item mod.zip mod.iwd"