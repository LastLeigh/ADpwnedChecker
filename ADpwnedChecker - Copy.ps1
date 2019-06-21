Get-ADUser | 
foreach-object { # Loop over adusers
 $emailaddress | # take the emailaddress property from the object
  foreach-object {$result = get-pwnedaccount -emailaddress $emailaddress # Run $mail against pwnedAPI
  start-sleep -seconds 2 # Avoid API blocking you from sending too many requests
 $result | Add-member -NotePropertyName EmailAddress -NotePropertyValue $mail
}
} | Tee-Object -Variable pwnedResults