#!/usr/bin/env pwsh
[CmdletBinding()]
Param(
  [Parameter(Mandatory = $True)]
  [String[]] $fqdn
)

$fqdnpattern="^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\.([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\.([a-zA-Z0-9]{2,})$"
if($fqdn -match $fqdnpattern){


$hosts = $fqdn  #| ConvertFrom-Json
foreach($FQDN in $hosts){
$DomainName=$FQDN.Substring($FQDN.IndexOf(".") + 1)
$Hostname = $FQDN.split('.')[0]
switch($DomainName){
'PRPRIVMGMT.Intraxa' {$DC='cdlz0001.PRPRIVMGMT.intraxa'}
'PPPRIVMGMT.Intraxa' {$DC='BDLZ0001.PPPRIVMGMT.intraxa'}
'WWMGMT.intraxa'     {$DC='cdlz0501.WWMGMT.intraxa'}
'axa-uk.intraxa'     {$DC='WSCADS02.axa-uk.intraxa'}
'adsgb.intraxa'      {$DC='wscads01.adsgb.intraxa'}
'adsgb-test.intraxa' {$DC='wtcads01.adsgb-test.intraxa'}
'axa-icas.net'       {$DC='wscads30.axa-icas.net'}
'axa-uk-test.intraxa'{$DC='WTCADS02.axa-uk-test.intraxa'}
'health-on-line.local'{$DC='wq3ads01.health-on-line.local'}
'medc.mgmt.axa-tech.intraxa'{$DC='ws3ads03.medc.mgmt.axa-tech.intraxa'}
'uk.axa-cs.intraxa'         {$DC='wz6ads01.uk.axa-cs.intraxa'}
'uk.axa-tech.intraxa'      {$DC='WSSADS01.uk.axa-tech.intraxa'}
'wlp.uk.winterthur.com'    {$DC='WSCADS22.wlp.uk.winterthur.com'}
'doleni.acc'                {$DC='WXCADS01.doleni.acc'}
'doleni.net'                {$DC='WWFADS01.doleni.net'}
'ch.doleni.net'              {$DC='WWFADS02.ch.doleni.net'}
'ch.doleni.acc'              {$DC='wxcads02.ch.doleni.acc'}
'chres1.doleni.net'    {$DC='WWCADS04.chres1.doleni.net'}
'chres1.doleni.acc'    {$DC='WXCADS03.chres1.doleni.acc'}
'pp-adsgb.intraxa'    {$DC='wtcadsp1.pp-adsgb.intraxa'}
'pp-axa-uk.intraxa'    {$DC='WTCADSP2.pp-axa-uk.intraxa'}
'pp-medc.pp-mgmt.axa-tech.intraxa'    {$DC='WT3ADSP3.pp-medc.pp-mgmt.axa-tech.intraxa'}
'doleni.dev'                          {$DC='WXFADSP1.doleni.dev'}
'ch.doleni.dev'                       {$DC='WXCADSP2.ch.doleni.dev'}
'applications.services.axa-tech.intraxa'    {$DC='W36ADS03.applications.services.axa-tech.intraxa'}
'adatum.com'                            {$DC='ec2amaz-fkd44pd.adatum.com'}
default                             {Write-host $DomainName does not exist in our scope -ForegroundColor Red; $DC=1}
}

if($DC -ne 1){


$Status= Get-ADComputer -Identity $Hostname -server $DC
If($status) {
Set-ADComputer -Identity $Hostname -server $DC -Enabled $false
}
else {
Write-host $Hostname not found on AD Console
}
$StatusConfirm = (Get-ADComputer -Identity $Hostname -server $DC).Enabled
If ($statusconfirm -eq $false) {Write-host Requested computer object $Hostname disabled from AD console}
elseif ($StatusConfirm -eq $true) {Write-host Requested computer object $Hostname still enabled on AD console}
Clear-Variable DomainName, DC, Hostname, Status, StatusConfirm







}


}

}

else{
write-host "Please enter the valide FQDN "

}