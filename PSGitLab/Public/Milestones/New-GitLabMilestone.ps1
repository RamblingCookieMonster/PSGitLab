Function New-GitLabMilestone {
    [cmdletbinding(SupportsShouldProcess=$true)]
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory)]
        [string]$ProjectId,

        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory)]
        [string]$Title,

        [string]$Description,
        
        [datetime]$DueDate
    )

    $Project = $Project = Get-GitlabProject -Id $ProjectId;

    $GetUrlParameters = @()
    $GetUrlParameters += @{title=$Title}

    if ($Description) {
        $GetUrlParameters += @{description=$Description}
    }
    if ($DueDate) {
        $GetUrlParameters += @{due_date=($DueDate).ToString("yyyy-MM-dd")}
    }

    $URLParameters = GetMethodParameters -GetURLParameters $GetUrlParameters

    $Request = @{
        URI="/projects/$($Project.id)/milestones$URLParameters";
        Method='POST';
    }

    if ($PSCmdlet.ShouldProcess('Create Milestone')) {
        QueryGitLabAPI -Request $Request -ObjectType 'GitLab.Milestone'
    }
}
