Get-AzSubscription –SubscriptionName "your sub" | Select-AzSubscription

$rg="<YOUR RG>"
New-AzStreamAnalyticsJob -File "adjob.json" -Name "jjadjob" -ResourceGroupName $rg
Start-AzStreamAnalyticsJob -ResourceGroupName $rg -Name "jjadjob"