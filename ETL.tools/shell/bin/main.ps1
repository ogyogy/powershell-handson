$configPath = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $configPath "../conf/main.config.ps1")

New-Item $logPath -ItemType Directory -Force

$logger.Info("Start Script")

$mutex = New-Object System.Threading.Mutex($false, "Global¥MUTEX_TEST")
if (!($mutex.WaitOne(0, $false))) {
    $logger.Warning("Already processing is executed")
    exit
}
$mainPath = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $mainPath "job1.ps1")
$mutex.ReleaseMutex()

$logger.Info("End Script")