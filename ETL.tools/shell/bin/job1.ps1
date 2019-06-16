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
foreach ($file in $fileList) {
    $tmpPath = Join-Path $scriptPath "/../../csv/tmp"
    Copy-Item $file ((Join-Path $tmpPath ($file.BaseName + "_tmp.csv")))
    $utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    # remove duplicate lines and overwrite
    [System.IO.File]::WriteAllLines($file, (Get-Content $file | Sort-Object | Get-Unique), $utf8NoBomEncoding)

}
