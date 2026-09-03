#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

$dir = Split-Path -Parent $PSCommandPath
Import-Module "$dir/../lib/Sentinel.Logging.psm1" -Force

function Get-SentinelUsers {
    Write-SentinelSection -Title "Users"
    Write-SentinelLog INFO "Collecting users"

    Get-LocalUser |
        Where-Object Enabled -eq $true
}

function Get-SentinelServices {
    Write-SentinelSection -Title "Running services"
    Write-SentinelLog INFO "Collecting running services"

    Get-Service -ErrorAction SilentlyContinue |
        Where-Object Status -eq Running
}

function Get-SentinelPorts {
    Write-SentinelSection -Title "Listening TCP ports"
    Write-SentinelLog INFO "Collecting listening TCP ports"

    Get-NetTCPConnection -State Listen
}

function Get-SentinelAdminMembers {
    Write-SentinelSection -Title "Administrators"
    Write-SentinelLog INFO "Collecting administrator members"

    Get-LocalGroupMember "Administratorer"
}

function Invoke-SentinelMain {
    Get-SentinelUsers
    Get-SentinelServices
    Get-SentinelPorts
    Get-SentinelAdminMembers

    Write-SentinelLog INFO "Sentinel complete"
}

Invoke-SentinelMain

exit 0