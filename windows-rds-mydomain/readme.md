# Remote Desktop Services deployment in Azure
This project creates servers for RDS. Each script creates defined RDS role.
Script is set of scripts for each role. Sometimes you need provision/automate only part of solution.

Prerequisities:
1. existing Vnet in Azure
2. existing Active Domain in Azure 
3. existing DNS configured in Azure, reffering AD controller

This project is base on this <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/rds-deployment">article</a>.

Script is using Powershell DSC script from link above - configuration of RDS roles (copy in configuration folder).

## Deploy RD gateway
Use following ARM template.
```
azuredeploy-vm-gw.json
```
Parameters needed: (azuredeploy-vm.parameters.json)
1. reference to Vnet
2. Active Domain administrator account

## Deploy RD Session hosts
There are two templates how to deploy RD Session hosts. 

### Deploy RD Session hosts as VMs
Use following ARM template.
```
azuredeploy-vm-rdsh.json
```
Parameters needed: (azuredeploy-vm.parameters.json)
1. reference to Vnet
2. Active Domain administrator account
3. Number of hosts to deploy

### Deploy RDS Session hosts as VMSS
This template is using Virtual Machine Scale Set.
```
azuredeploy-vmss-rdsh.json
```
Parameters needed: (azuredeploy-vm.parameters.json)
1. reference to Vnet
2. Active Domain administrator account
3. Number of instances in VMSS

On host run this command to add host in deployment and collection (broker must be deployed first)
```powershell
Add-RDServer -Server rdshx000009.jjdev.local -Role "RDS-RD-SERVER" -ConnectionBroker broker.jjdev.local
Add-RDSessionHost -CollectionName "Desktop Collection" -SessionHost rdshx000009.jjdev.local -ConnectionBroker broker.jjdev.local
```

## Deploy RD Connection Broker
Use following ARM template.
```
azuredeploy-vm-cb.json
```
Parameters needed: (azuredeploy-vm-cb.parameters.json)
1. reference to Vnet
2. Active Domain administrator account
3. Number of hosts to deploy
4. public IP parameters

## Test access
If you will use my settings, you can start browser with
```
https://gateway.jjdev.local/RDWeb
```
