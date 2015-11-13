<#
    .Synopsis
#>
workflow Deploy-Integration
{
    Param(
        [Parameter(Mandatory = $True)]
        [String]
        $CurrentCommit,

        [Parameter(Mandatory = $True)]
        [String]
        $RepositoryName,

        [Parameter(Mandatory=$True)]
        [pscredential]
        $Credential
    )

    Write-Verbose -Message "Starting [$WorkflowCommandName]"
    $ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop

    Foreach($RunbookFile in (Get-ChildItem -Path ..\Runbooks -Recurse -Filter *.ps1))
    {
        Publish-SMARunbookChange -FilePath $RunbookFile.FullName -CurrentCommit $currentcommit -RepositoryName $repositoryname -Credential $credential
    }
    Foreach($SettingsFile in (Get-ChildItem -Path ..\Globals -Recurse -Filter *.json))
    {
        Publish-SMASettingsFileChange -FilePath $SettingsFile.FullName -CurrentCommit $currentcommit -RepositoryName $repositoryname -Credential $credential
    }
    Write-Verbose -Message "Finished [$WorkflowCommandName]"
}
