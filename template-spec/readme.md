# Azure Resource Manager template specs

Enabled Preview https://github.com/Azure/template-specs

How to use it https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-specs-create-linked

Deploy template spec

```powershell
New-AzResourceGroup -Name "jjtemplates-rg" -Location "WestEurope"
New-AzTemplateSpec -Name storageSpec -Location "WestEurope" -Version 1.0 -ResourceGroupName "jjtemplates-rg" -TemplateJsonFile ./template-storage.json
Get-AzTemplateSpec
```

Deploy main template

```powershell
New-AzResourceGroup -Name "jjtest-rg" -Location "WestEurope"
New-AzResourceGroupDeployment -ResourceGroupName "jjtest-rg" -TemplateFile ./template-main.json
```
