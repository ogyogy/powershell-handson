# include config
$configPath = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $configPath "../conf/job1.config.ps1")

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
        $logger.INFO("Convert Shift-JIS to UTF-8N, and copy upload csv to backup csv")
        [System.IO.File]::WriteAllLines($uploadCsv, (Get-Content $uploadCsv | Sort-Object | Get-Unique), $utf8NoBomEncoding)
        
        # TODO: upload to azure
    
        $logger.INFO("Copy upload csv to backup csv")
        Move-Item $uploadCsv ((Join-Path $backupPath ($uploadCsv.BaseName + "_backup.csv"))) -force

        $logger.INFO("Remove tmp csv")
        Remove-Item $tmpCsv
        
        $logger.INFO("Upload success")
    }
    catch {
        $logger.Error("Upload failured")

        $logger.INFO("Copy tmp csv to upload csv")
        Copy-Item $tmpCsv $uploadCsv

        $logger.INFO("Copy tmp csv to reject csv")
        Copy-Item $tmpCsv ((Join-Path $rejectPath ($uploadCsv.BaseName + "_reject.csv")))

        $logger.INFO("Remove tmp csv")
        Remove-Item $tmpCsv
    }
}
