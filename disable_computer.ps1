
$host_names= $env:PT_hostnames
$hosts = $host_names| ConvertFrom-Json
foreach($FQDN in $hosts){
write-host "disabling $fqdn computer object...."
$DomainName=$FQDN.Substring($FQDN.IndexOf(".") + 1)
$Hostname = $FQDN.split('.')[0]
If ($DomainName -eq 'PRPRIVMGMT.Intraxa') {$DC='cdlz0001.PRPRIVMGMT.intraxa'}
elseif ($DomainName -eq 'PPPRIVMGMT.Intraxa') {$DC='BDLZ0001.PPPRIVMGMT.intraxa'}
elseif ($DomainName -eq 'WWMGMT.intraxa') {$DC='cdlz0501.WWMGMT.intraxa'}
elseif ($DomainName -eq 'axa-uk.intraxa') {$DC='WSCADS02.axa-uk.intraxa'}
elseif ($DomainName -eq 'adsgb.intraxa') {$DC='wscads01.adsgb.intraxa'}
elseif ($DomainName -eq 'adsgb-test.intraxa') {$DC='wtcads01.adsgb-test.intraxa'}
elseif ($DomainName -eq 'axa-icas.net') {$DC='wscads30.axa-icas.net'}
elseif ($DomainName -eq 'axa-uk-test.intraxa') {$DC='WTCADS02.axa-uk-test.intraxa'}
elseif ($DomainName -eq 'health-on-line.local') {$DC='wq3ads01.health-on-line.local'}
elseif ($DomainName -eq 'medc.mgmt.axa-tech.intraxa') {$DC='ws3ads03.medc.mgmt.axa-tech.intraxa'}
elseif ($DomainName -eq 'uk.axa-cs.intraxa') {$DC='wz6ads01.uk.axa-cs.intraxa'}
elseif ($DomainName -eq 'uk.axa-tech.intraxa') {$DC='WSSADS01.uk.axa-tech.intraxa'}
elseif ($DomainName -eq 'wlp.uk.winterthur.com') {$DC='WSCADS22.wlp.uk.winterthur.com'}
elseif ($DomainName -eq 'doleni.acc') {$DC='WXCADS01.doleni.acc'}
elseif ($DomainName -eq 'doleni.net') {$DC='WWFADS01.doleni.net'}
elseif ($DomainName -eq 'ch.doleni.net') {$DC='WWFADS02.ch.doleni.net'}
elseif ($DomainName -eq 'ch.doleni.acc') {$DC='wxcads02.ch.doleni.acc'}
elseif ($DomainName -eq 'chres1.doleni.net') {$DC='WWCADS04.chres1.doleni.net'}
elseif ($DomainName -eq 'chres1.doleni.acc') {$DC='WXCADS03.chres1.doleni.acc'}
elseif ($DomainName -eq 'pp-adsgb.intraxa') {$DC='wtcadsp1.pp-adsgb.intraxa'}
elseif ($DomainName -eq 'pp-axa-uk.intraxa') {$DC='WTCADSP2.pp-axa-uk.intraxa'}
elseif ($DomainName -eq 'pp-medc.pp-mgmt.axa-tech.intraxa') {$DC='WT3ADSP3.pp-medc.pp-mgmt.axa-tech.intraxa'}
elseif ($DomainName -eq 'doleni.dev') {$DC='WXFADSP1.doleni.dev'}
elseif ($DomainName -eq 'ch.doleni.dev') {$DC='WXCADSP2.ch.doleni.dev'}
elseif ($DomainName -eq 'applications.services.axa-tech.intraxa') {$DC='W36ADS03.applications.services.axa-tech.intraxa'}
elseif ($DomainName -eq 'adatum.com') {$DC='ec2amaz-fkd44pd.adatum.com'}

else {Write-host $DomainName does not exist in our scope;}
#Check the AD Computer object enable/disable status. If found enabled, disables the AD Computer object.
$Status= Get-ADComputer -Identity $Hostname -server $DC
If($status) {Set-ADComputer -Identity $Hostname -server $DC -Enabled $false} else {Write-host $Hostname not found on AD Console}
#Re-Check the AD Computer object enable/disable status & confirm with a display message.
$StatusConfirm = (Get-ADComputer -Identity $Hostname -server $DC).Enabled
If ($statusconfirm -eq $false) {Write-host Requested computer object $Hostname disabled from AD console}
elseif ($StatusConfirm -eq $true) {Write-host Requested computer object $Hostname still enabled on AD console}
#Remove-ADComputer -Identity $hostname -server $DC
#Write-Host $DomainName, $DC, $Hostname
Clear-Variable DomainName, DC, Hostname, Status, StatusConfirm
}