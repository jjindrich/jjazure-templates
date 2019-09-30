# Azure Firewall deploywment with rules

## Deploy

```powershell
$rg = "JJDevV2-Infra"
az group deployment create -g $rg --template-file deploy-fw.json --parameters deploy-fw.params.json
az network vnet subnet update -g $rg -n DmzInfra --vnet-name JJDevV2Network --route-table jjdevv2fw-rt
```

## Remove firewall

```powershell
az network vnet subnet update -g $rg -n DmzInfra --vnet-name JJDevV2Network --remove routeTable 
```
