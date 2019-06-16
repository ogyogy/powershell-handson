$configPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# setting script variable
$jobId = "job1"
$csvPath = Join-Path $configPath "/../../csv/"
$uploadPath = Join-Path $csvPath (Join-Path "upload" $jobId)
$tmpPath = Join-Path $csvPath (Join-Path "tmp" $jobId)
$rejectPath = Join-Path $csvPath (Join-Path "reject" $jobId)
$backupPath = Join-Path $csvPath (Join-Path "backup" $jobId)

# load log4net dll
Add-Type -Path (Join-Path $configPath "../conf/log4net.dll")

# load log4net setting file
$configFile = Get-Item (Join-Path $configPath "../conf/log4net.xml")
[log4net.Config.XmlConfigurator]::Configure($configFile)

# logger name is script name
$logger = [log4net.LogManager]::GetLogger($script:myInvocation.MyCommand.Name)

# setting loger
$rootLogger = ($logger.Logger.Repository).Root
[log4net.Appender.RollingFileAppender]$appender = [log4net.Appender.FileAppender]$rootLogger.GetAppender("RollingFileAppender")
$logPath = Join-Path $configPath "../../logs/"
$datePattern = (Get-Date -Format yyyyMMdd) + ".log"
$appender.File = Join-Path $logPath $datePattern
$appender.ActivateOptions()