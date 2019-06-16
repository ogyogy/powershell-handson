# get script path
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# set upload path
$uploadName = "/../../csv/upload"
$uploadPath = $scriptPath + $uploadName

# debug print
Write-Host $uploadPath

# check upload foler
if (Test-Path $uploadPath)
{
    Write-Host "Success"
}
else
{
    Write-Host "Rejected"
}
