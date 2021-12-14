function ExecuteTask{
$SiteName="CMH1"
$SCCMServer="cmhprdsccm10.domain.local"
$SCCMNameSpace="root\sms\site_$SiteName"

$list = Import-csv 'C:\Users\dkirk\OneDrive - NetJets\Desktop\un.csv'

$Users = Foreach($Object in $list.cn)
    {
        Try{
        $currentUser = Get-ADuser -Filter {cn -eq $Object} -Properties * | Select-Object Samaccountname
        write-host $currentUser.Samaccountname
        }
        Catch{

            Write-host $object.cn Does not Exist -ForegroundColor Red
        }
    }
Get-WmiObject -namespace $SCCMNameSpace -computer $SCCMServer -query "select Name from sms_r_system where LastLogonUserName='$Users'" | select Name | export-csv -path 'C:\Users\dkirk\OneDrive - NetJets\Desktop\results.csv'

   

    }ExecuteTask