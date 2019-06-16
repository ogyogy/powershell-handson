$mutex = New-Object System.Threading.Mutex($false, "Global¥MUTEX_TEST")
if (!($mutex.WaitOne(0, $false))) {
    Write-Warning "Already processing is executed."
    Read-Host "Press Enter and exit"
    exit
}
$mainPath = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $mainPath "job1.ps1")
$mutex.ReleaseMutex()