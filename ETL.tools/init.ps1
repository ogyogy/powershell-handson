$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
New-Item $scriptPath"/logs" -ItemType Directory -Force
New-Item $scriptPath"/csv/upload" -ItemType Directory -Force
New-Item $scriptPath"/csv/backup" -ItemType Directory -Force
New-Item $scriptPath"/csv/reject" -ItemType Directory -Force
New-Item $scriptPath"/csv/tmp" -ItemType Directory -Force
New-Item $scriptPath"/shell/bin" -ItemType Directory -Force
New-Item $scriptPath"/shell/conf" -ItemType Directory -Force