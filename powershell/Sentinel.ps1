#!/usr/bin/env pwsh
$ErrorActionPreference = 'Stop'

$dir = Split-Path -Parent $PSCommandPath
Import-Module "$dir/../lib/Sentinel.Logging.psm1" -Force

function Get-SentinelUsers {
    Write-SentinelSection -Title "Users"
    Get-Content /etc/passwd | ForEach-Object {
        $f = $_.Split(':')
        if ([int]$f[2] -ge 1000 -and
            $f[6] -notmatch 'nologin|false') {
            $f[0]
        }
    }
}

function Get-SentinelServices {
    Get-Service | Where-Object Status -eq Running
}

function Get-SentinelPorts {
    Get-NetTCPConnection -State Listen
}

function Get-SentinelSudoMembers {
    Get-LocalGroupMember Administrators
}

function Invoke-SentinelMain {
    Get-SentinelUsers
    Get-SentinelServices
    Get-SentinelPorts
    Get-SentinelSudoMembers
}

Invoke-SentinelMain