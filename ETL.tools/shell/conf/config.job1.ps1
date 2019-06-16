
$debugSuccess = "false"
$debugErr = "false"
$debugLog = "false"
$configPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$csvPath = Join-Path $configPath "/../../csv/"
$jobId = "job1"
$uploadPath = Join-Path $csvPath (Join-Path "upload" $jobId)
$tmpPath = Join-Path $csvPath (Join-Path "tmp" $jobId)
$rejectPath = Join-Path $csvPath (Join-Path "reject" $jobId)
$backupPath = Join-Path $csvPath (Join-Path "backup" $jobId)