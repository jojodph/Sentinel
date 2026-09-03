function Write-SentinelLog {
    param(
        [Parameter(Mandatory)]
        [ValidateSet('INFO','WARN','ERROR')]
        [string]$Level,

        [Parameter(Mandatory)]
        [string]$Message
    )

    $t = Get-Date -Format 'o'
    Write-Host "$t [$Level] $Message"
}