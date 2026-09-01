# Variables configured in form
$user = $form.gridUsers
$lifetimeMinutes = $form.tempAccessPass.lifetimeInMinutes
$startDateTime = $form.tempAccessPass.startDateTime
$isUsableOnce = $form.tempAccessPass.isUsableOnce

# Set debug logging
$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

try {
    # Create audit log for Temporary Access Pass generation
    # Note: The TAP is already generated in the datasource/form, this task only creates the audit log
    # Security: The TAP value itself is NOT logged for security reasons
    $Log = @{
        Action            = "SetPassword" # optional. ENUM (undefined = default) 
        System            = "EntraID" # optional (free format text) 
        Message           = "Successfully generated Temporary Access Pass for user [$($user.displayName)] with id [$($user.id)]. Lifetime: [$lifetimeMinutes] minutes ([$([math]::Round($lifetimeMinutes / 60, 2))] hours), Start: [$startDateTime], Usable once: [$isUsableOnce]" # required (free format text) 
        IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
        TargetDisplayName = $user.displayName # optional (free format text)
        TargetIdentifier  = $user.id # optional (free format text)
    }
    #send result back  
    Write-Information -Tags "Audit" -MessageData $log

}
catch {
    $ex = $PSItem
    $auditMessage = "Error creating audit log for Temporary Access Pass generation for user [$($user.displayName)] with id [$($user.id)]. Error: $($ex.Exception.Message)"
    $warningMessage = "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"

    $Log = @{
        Action            = "SetPassword" # optional. ENUM (undefined = default) 
        System            = "EntraID" # optional (free format text)
        Message           = $auditMessage # required (free format text) 
        IsError           = $true # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
        TargetDisplayName = $user.displayName # optional (free format text)
        TargetIdentifier  = $user.id # optional (free format text)
    }
    Write-Information -Tags "Audit" -MessageData $log
    Write-Warning $warningMessage
    Write-Error $auditMessage
}
