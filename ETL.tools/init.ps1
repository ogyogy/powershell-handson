Remove-Item "./csv/upload/job1/*.csv"
Remove-Item "./csv/tmp/job1/*.csv"
Remove-Item "./csv/reject/job1/*.csv"
Remove-Item "./csv/backup/job1/*.csv"
Remove-Item "./csv/upload/job1/*.csv"
Copy-Item test.csv (Join-Path ./csv/upload/job1 ((Get-Date -Format yyyyMMddhhmmss) + ".csv"))