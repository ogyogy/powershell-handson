$configPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Remove-Item (Join-Path $configPath "/csv/upload/job1/*.csv")
Remove-Item (Join-Path $configPath "/csv/tmp/job1/*.csv")
Remove-Item (Join-Path $configPath "/csv/reject/job1/*.csv")
Remove-Item (Join-Path $configPath "/csv/backup/job1/*.csv")
Remove-Item (Join-Path $configPath "/csv/upload/job1/*.csv")
Remove-Item (Join-Path $configPath "/logs/*.log*")
Copy-Item (Join-Path $configPath "test.csv") (Join-Path (Join-Path $configPath "/csv/upload/job1") ((Get-Date -Format yyyyMMddhhmmss) + ".csv"))