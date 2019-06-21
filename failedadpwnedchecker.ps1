get-aduser -filter * -Properties mail | select-object mail |
 ForEach-Object { # Loop over each user object.
    $_.mail  # Grab the property
    $result = Get-PwnedAccount -emailaddress $_ # Set $result to the result of the PWNed api module command running each object in $_
    Start-Sleep -Seconds 2 # Avoid the API rate limiting.
$result | Add-Member -NotePropertyName EmailAddress -NotePropertyValue $_ # Grab each entry made by this foreach-object loop
} | Tee-Object -Variable pwnedResults