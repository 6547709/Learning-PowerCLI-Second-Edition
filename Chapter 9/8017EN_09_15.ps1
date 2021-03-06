Get-AlarmDefinition -Name 'Datastore usage on disk' |
Get-AlarmAction -ActionType SendEmail |
Get-AlarmActionTrigger |
Where-Object {$_.StartStatus -eq 'Green'} |
Remove-AlarmActionTrigger -Confirm:$false