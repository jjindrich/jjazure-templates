# Remote Desktop Services deployment in Azure
This project creates servers for RDS. Each script creates defined RDS role.
Script is set of scripts for each role. Sometimes you need provision/automate only part of solution.

Prerequisities:
1. existing Vnet in Azure
2. existing Active Domain in Azure 
3. existing DNS configured in Azure, reffering AD controller

This project is base on this <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/rds-deployment">article</a>.

## Deploy RD gateway
Use following ARM template.
```
azuredeploy-vm-gw.json
```
Parameters needed: (azuredeploy-vm.parameters.json)
1. reference to Vnet
2. Active Domain administrator account

## Deploy RD Session hosts
Use following ARM template.
```
azuredeploy-vm-rdsh.json
```
Parameters needed: (azuredeploy-vm.parameters.json)
1. reference to Vnet
2. Active Domain administrator account
3. Number of hosts to deploy

## Deploy RD Connection Brokes
Use following ARM template.
```
azuredeploy-vm-cb.json
```
Parameters needed: (azuredeploy-vm-cb.parameters.json)
1. reference to Vnet
2. Active Domain administrator account
3. Number of hosts to deploy
4. public IP parameters


