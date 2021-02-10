# Script for overwriting Dockerized [REDACTED] databases with dev backups.
#
# Make sure to update the variables below before running.

$DbBackupServerName = "REPLACE: database backup server name" 
$DbDockerContainerName = "REPLACE: database Docker container name"
$DbPassword = "REPLACE: database password"

function Main-Logic {
    param(
        [string] $DbBackupServer,
        [string] $DbContainerName,
        [string] $DbPassword
    )

    $DbBackupLocation = "\\$DbBackupServer\BACKUPS-DeveloperCopy\"

    docker cp $DbBackupLocation ${DbContainerName}:/var/opt/mssql/data

	foreach ($db in gci $DbBackupLocation)
	{
		RunSqlRestore `
            -DatabaseName $db.BaseName `
            -ContainerName $DbContainerName `
            -DatabasePassword $DbPassword
	}
}

function RunSqlRestore {
    param(
        [string] $DatabaseName,
        [string] $ContainerName,
        [string] $DatabasePassword
    )

    $Script = GetScript -DatabaseName $DatabaseName
    Echo $Script
    docker exec -it ${ContainerName} /opt/mssql-tools/bin/sqlcmd `
        -S localhost,1433 `
        -U SA `
        -P $DatabasePassword `
        -Q $Script
}

function GetScript {
    param([string] $DatabaseName)

    $DbScriptTemplate = "USE [master]
RESTORE DATABASE [{{databaseName}}]
FROM  DISK = N'/var/opt/mssql/data/{{databaseName}}.bak' WITH  FILE = 1
,MOVE N'{{databaseName}}' TO N'/var/opt/mssql/data/{{databaseName}}.mdf'
,MOVE N'{{databaseName}}_log' TO N'/var/opt/mssql/data/{{databaseName}}_log.ldf'
,NOUNLOAD
,REPLACE
,STATS = 5"
    $Script = $DbScriptTemplate -replace "{{databaseName}}",$DatabaseName
    Write-Output $Script
}

Main-Logic $DbBackupServerName $DbDockerContainerName $DbPassword