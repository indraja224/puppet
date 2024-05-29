#!/usr/bin/env pwsh
[CmdletBinding()]
Param(
  [Parameter(Mandatory = $True)]
  [String[]] $fqdn
)

$fqdnpattern="^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\.([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\.([a-zA-Z0-9]{2,})$"
foreach($F in $fqdn){
if($f -match $fqdnpattern){
try
{
    $domain = ($f -split '\.')[1..2] -join '.'
    $Hostname = $F.split('.')[0]
    $dc=Get-ADDomainController -Filter { Domain -eq $domain }  | Select-Object -ExpandProperty HostName
    if ($dc) {
        Write-host "Domain Controller of $f : $dc" -ForegroundColor Green
        if((Get-ADComputer -Identity $hostname -server $DC).enabled -eq $true ){
        Set-ADComputer -Identity $hostname -server $DC -Enabled $false
        Write-host "Requested computer object $hostname disabled from $dc AD console"
        }
        else{
        Write-host "Requested computer object $hostname from $dc already disabled "
        }
    }
    else {
        Write-Output "Unable to find Domain Controller with $domain"
    }
    }
    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
    write-host "$hostname is not exist in $DC" -ForegroundColor Cyan
    }
    catch{
    Write-Output "$_"

    }

}
else{
write-host "please provide the FQDN of $f" -ForegroundColor Red
}
}