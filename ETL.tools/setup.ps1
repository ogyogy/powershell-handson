$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
New-Item $scriptPath"/logs" -ItemType Directory -Force
New-Item $scriptPath"/csv/upload/job1" -ItemType Directory -Force
New-Item $scriptPath"/csv/backup/job1" -ItemType Directory -Force
New-Item $scriptPath"/csv/reject/job1" -ItemType Directory -Force
New-Item $scriptPath"/csv/tmp/job1" -ItemType Directory -Force
New-Item $scriptPath"/shell/bin" -ItemType Directory -Force
New-Item $scriptPath"/shell/conf" -ItemType Directory -Force