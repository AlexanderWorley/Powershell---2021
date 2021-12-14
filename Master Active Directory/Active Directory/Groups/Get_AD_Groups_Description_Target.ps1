Import-Module activedirectory
#Input a server name - example: cmhprdfps53
#Once inputted as long as the share group has that server in the description it should show up in this list.
$server = Read-Host "Input the server you wish to pull"
$servertarget = "*"+$Server+"*"
get-adgroup -filter {Description -LIKE $Servertarget } | Select Name | Sort name