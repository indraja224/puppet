#!/usr/bin/env pwsh
[CmdletBinding()]
Param(
  [Parameter(Mandatory = $True)]
  [String[]] $servers,
  [Parameter(Mandatory = $True)]
  [String] $groups,
  [Parameter(Mandatory = $True)]
  [String] $cyber_arc_account

)
$cyber_arc_account=$cyber_arc_account+"*"
$shared_accounts_list=(Get-ADUser -Filter {Name -like $cyber_arc_account}).name
function assign_admin($srv){
$grp="srv_"+$srv+"_Admin"
if( Get-ADGroup -Filter {Name -eq $grp}){
foreach ($ac in $shared_accounts_list){
if((get-ADGroupMember -Identity $grp).name -ccontains $ac){
write-host "$ac already exists in group $grp"
}
else{
Add-ADGroupMember -Identity $grp -Members $ac
write-host "added $ac to the group $grp"
}
}
}
else{
write-host "the Group $grp does not exist"

}


}
function assign_rdp($srv){
$grp="srv_"+$srv+"_rdp"
if( Get-ADGroup -Filter {Name -eq $grp}){
foreach ($ac in $shared_accounts_list){
if((get-ADGroupMember -Identity $grp).name -ccontains $ac){
write-host "$ac already exists in group $grp"
}
else{
Add-ADGroupMember -Identity $grp -Members $ac
write-host "added $ac to the group $grp"
}
}
}
else{
write-host "the Group $grp does not exist"

}


}

foreach($srv in $servers){
if($groups -eq "admin"){
assign_admin -srv $srv
}
if($groups -eq "rdp"){
assign_rdp -srv $srv
}

}

