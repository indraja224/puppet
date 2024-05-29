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
        $rdp_group="srv_"+$hostname+"_rdp"
        $admin_group="srv_"+$hostname+"_admin"
        $Status= Get-ADComputer -Identity $Hostname -server $DC
        If($status){
        Remove-ADComputer -Identity $hostname -server $DC -Confirm:$false
        write-host "$hostname removed from AD console.."
        }
        else {
        Write-host $Hostname not found on AD Console -ForegroundColor Cyan
        }


        if( Get-ADGroup -Filter {Name -eq $rdp_group} -server $dc){
        Remove-ADGroup -Identity $rdp_group -server $dc -Confirm:$false
        Write-Host "Group $rdp_group has been deleted."
        }
        else{
            Write-Host "Group $rdp_group does not exist."
        }

        if( Get-ADGroup -Filter {Name -eq $admin_group} -server $dc){
        Remove-ADGroup -Identity $admin_group -server $dc -Confirm:$false
        Write-Host "Group $admin_group has been deleted."
        }
        else{
    Write-Host "Group $admin_group does not exist."
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
Write-Output "Please enter the fqdn of $f"
}



}