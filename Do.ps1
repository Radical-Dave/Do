#Set-StrictMode -Version Latest
#####################################################
# Do
#####################################################
<#PSScriptInfo

.VERSION 0.0

.GUID 602bc07e-a621-4738-8c27-0edf4a4cea8e

.AUTHOR David Walker, Sitecore Dave, Radical Dave

.COMPANYNAME David Walker, Sitecore Dave, Radical Dave

.COPYRIGHT David Walker, Sitecore Dave, Radical Dave

.TAGS sitecore powershell local install iis solr

.LICENSEURI https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal/blob/main/LICENSE

.PROJECTURI https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


#>

<#
.SYNOPSIS
Do All The Things!

.DESCRIPTION
PowerShell script that helps you DO, All The Things!

.EXAMPLE
PS> .\Do 'name'

.EXAMPLE
PS> .\Do 'name' 'template'

.EXAMPLE
PS> .\Do 'name' 'template' 'd:\repos'

.Link
https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal

.OUTPUTS
    System.String
#>
Param(
	[string] $action = "help",
	[switch] $Force = $false
)
$StopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
$StopWatch.Start()

Write-Host "do:$action" -ForegroundColor White

$ogp = Get-Location
Set-Location $PSScriptRoot

if (Test-Path 'do.json') {
	$tasks = Get-Content .\do.json | Out-String | Invoke-Expression
	$task = $tasks[$action]
	if ($task) {
		if ($task -like '.\*') {
			$path = (Join-Path $PSScriptRoot ($task.Remove(0,2)))
			Write-Host $path -ForegroundColor White
			Invoke-Expression -Command $path
		} else {
			Invoke-Expression -Command $task
		}
	} elseif ($action -ne 'help') {
		Write-Host "Task not found in do.json: $action" -ForegroundColor White
	}
}

if ($action -eq 'help' -or !$task) {
	Write-Host '\n########################################' -ForegroundColor White
	Write-Host '\n\nTasks:\n' -ForegroundColor White
	foreach($task in $tasks.Keys) {
		Write-Host "$($task):$($tasks[$task])" -ForegroundColor White
	}
	Write-Host '\n########################################' -ForegroundColor White
}

Set-Location $ogp

$StopWatch.Stop()
$StopWatch