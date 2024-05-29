[CmdletBinding()]
Param(
  [Parameter(Mandatory = $false)]
  [String[]]$groupname,
  [Parameter(Mandatory = $false)]
  [String]$scope,
  [Parameter(Mandatory = $false)]
  [String]$grouptype
  )

#$groups = $groupname | ConvertFrom-Json

foreach($grp in $groupname){
if( Get-ADGroup -Filter {Name -eq $grp}){
write-host " Group $grp already exist "
}
else{
New-ADGroup -Name $grp -GroupScope $scope -GroupCategory $grouptype
write-output " Group $grp is created successfully ......"

}


}