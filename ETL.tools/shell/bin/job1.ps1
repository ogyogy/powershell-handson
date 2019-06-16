# get script path
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# set upload path
$uploadPath = Join-Path $scriptPath "/../../csv/upload"

# debug print
# Write-Host $uploadPath

# check upload foler
if (!(Test-Path $uploadPath)) {
    -ErrorAction Stop
}

$fileList = Get-ChildItem $uploadPath/* -include *.csv | Sort-Object LastWriteTime
foreach ($uploadCsv in $fileList) {
    $uploadFile = $uploadCsv.BaseName + $uploadCsv.Extension

    $tmpPath = Join-Path $scriptPath "/../../csv/tmp"
    $tmpCsv = ((Join-Path $tmpPath ($uploadCsv.BaseName + "_tmp.csv")))

    $rejectPath = Join-Path $scriptPath "/../../csv/reject"
    $rejectCsv = ((Join-Path $rejectPath $uploadFile))

    $backupPath = Join-Path $scriptPath "/../../csv/backup"
    $backupCsv = ((Join-Path $backupPath $uploadFile))

    Copy-Item $uploadCsv $tmpCsv

    try {
        $utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        # remove duplicate lines and overwrite
        [System.IO.File]::WriteAllLines($uploadCsv, (Get-Content $uploadCsv | Sort-Object | Get-Unique), $utf8NoBomEncoding)
        
        # TODO: upload to azure
    
        # TODO: if upload success
        Move-Item $uploadCsv $backupCsv -force
        Remove-Item $tmpCsv

        # DEBUG: throw error
        # throw "err"
    }
    catch {
        # TODO: if process failure
        # Read-Host "Copy tmp csv to upload csv"
        Copy-Item $tmpCsv $uploadCsv
        # Read-Host "Copy tmp csv to reject csv"
        Copy-Item $tmpCsv $rejectCsv
        # Read-Host "Remove tmp csv"
        Remove-Item $tmpCsv
    }
}
