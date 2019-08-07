function Get-PWNedAccounts {
    [CmdletBinding()]
    param()   
        # Building variables from grabing the AD Accounts from an AD.
        $ADUsers = Get-ADUser -Filter '*' -Properties *
        $EmailAddresses = $ADUsers.Emailaddress
        # Beginning loop over the AD accounts to run them against the PWNed database.
        foreach ($address in $EmailAddresses) {
            # If statement to clean the output a bit.    
            if ($address) {
                $PwnedAddress = Get-PwnedAccount -EmailAddress $address
                    # Further cleaning of the output so that only emails with results get listed
                    if ($PwnedAddress.name -ne $null) {
                        [PSCustomObject]@{
                            EmailAddress = $address
                            BreachEvent = $PwnedAddress.Name
                            BreachDate = $PwnedAddress.BreachDate
                            Verified = $PwnedAddress.IsVerified
                       }
                }
                
                # Sleeping due to API limiting
                Start-Sleep -s 2
            }
        }
}

Get-PWNedAccounts
