# Login Azure PowerShell using Service Principal
# Create App registration in AAD and assign permission to Azure resource you want to manage it
 
$userId = "68e48a72-7948-4471-af92-2a6bf270636b@jjdev.onmicrosoft.com"
$password = ConvertTo-SecureString "SECRET" -AsPlainText -Force 
$cred = New-Object -TypeName System.Management.Automation.PSCredential($userId ,$password) 

Connect-AzureRmAccount -ServicePrincipal -Credential $cred -TenantId "5bf07991-ef59-43e0-861c-ab35a6cfc932"

# Use credentials from Azure Automation
# https://docs.microsoft.com/en-us/azure/automation/automation-first-runbook-textual-powershell

$connection = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzureRmAccount -ServicePrincipal -Tenant $connection.TenantID -ApplicationID $connection.ApplicationID -CertificateThumbprint $connection.CertificateThumbprint