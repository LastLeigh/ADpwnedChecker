Get-ADUser -Filter '*' -Properties * | $emailaddress = foreach-object -Property emailaddress 
{
$result = Get-PwnedAccount -emailaddress $emailaddress
start-sleep -seconds 2
$result | add-member -notepropertyname EmailAddress -NotePropertyValue $emailaddress 
}
| Tee-Object -Variable pwnedResults
