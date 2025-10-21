@echo off

echo Starting building mod

echo converting .dds images to .iwi
py bin\convert_dds.py
del mod.iwd

echo Creating iwd mod
powershell -Command "Compress-Archive -Force -Path mp,ui_mp,ui,scripts,maps,images -DestinationPath mod.zip; Rename-Item mod.zip mod.iwd"