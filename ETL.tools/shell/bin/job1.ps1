# include config
$job1Path = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $job1Path "../conf/config.job1.ps1")

# check & make folder
New-Item (Join-Path $csvPath (Join-Path "upload" $jobId)) -ItemType Directory -Force
New-Item (Join-Path $csvPath (Join-Path "tmp" $jobId)) -ItemType Directory -Force
New-Item (Join-Path $csvPath (Join-Path "reject" $jobId)) -ItemType Directory -Force
New-Item (Join-Path $csvPath (Join-Path "backup" $jobId)) -ItemType Directory -Force

$fileList = Get-ChildItem $uploadPath/* -include *.csv | Sort-Object LastWriteTime
foreach ($uploadCsv in $fileList) {
    $tmpCsv = ((Join-Path $tmpPath ($uploadCsv.BaseName + "_tmp.csv")))
    Copy-Item $uploadCsv $tmpCsv

    try {
        $utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        # remove duplicate lines and overwrite
        [System.IO.File]::WriteAllLines($uploadCsv, (Get-Content $uploadCsv | Sort-Object | Get-Unique), $utf8NoBomEncoding)
        
        # TODO: upload to azure
        
        # DEBUG: throw error
        if ($debugErr.ToLower() -eq "true") {
            throw "err"
        }
        
        # TODO: if upload success
        if ($debugSuccess.ToLower() -eq "true") {
            Read-Host "Copy upload csv to backup csv"
        }
        Move-Item $uploadCsv ((Join-Path $backupPath ($uploadCsv.BaseName + "_backup.csv"))) -force
        if ($debugSuccess.ToLower() -eq "true") {
            Read-Host "Remove tmp csv"
        }
        Remove-Item $tmpCsv
        
        # debug log example
        if ($debugLog.ToLower() -eq "true") {
            Write-Output "log: Success"
        }
    }
    catch {
        # debug log example
        if ($debugLog.ToLower() -eq "true") {
            Write-Output "log: Failured"
        }

        # TODO: if process failure
        if ($debugErr.ToLower() -eq "true") {
            Read-Host "Copy tmp csv to upload csv"
        }
        Copy-Item $tmpCsv $uploadCsv
        if ($debugErr.ToLower() -eq "true") {
            Read-Host "Copy tmp csv to reject csv"
        }
        Copy-Item $tmpCsv ((Join-Path $rejectPath ($uploadCsv.BaseName + "_reject.csv")))
        if ($debugErr.ToLower() -eq "true") {
            Read-Host "Remove tmp csv"
        }
        Remove-Item $tmpCsv
    }
}
