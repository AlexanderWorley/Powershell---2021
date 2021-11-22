using namespace System.Management.Automation;
function error-repo{

$errortable = @{

1 = 'Device is offline to your machine'
2 = 'Dell Service Tag is incorrect/missing'
    

    }
$errorCat = @{

1 = 'Connection'
2 = 'Incorrect input'

}


$Exception = [Exception]::new("error message")
$ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
    $Exception,
    "errorID",
    [System.Management.Automation.ErrorCategory]::NotSpecified,
    $TargetObject # usually the object that triggered the error, if possible
)
$PSCmdlet.ThrowTerminatingError($ErrorRecord)

}error-repo