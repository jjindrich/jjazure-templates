# Deploy a VM Scale Set of Linux VMs with a custom script extension

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjjindrich%2Fazure-templates%2Fmaster%2Fvmss-custom-script-linux%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

This template allows you to deploy a VM Scale Set of Linux VMs with a custom script run on each VM. To connect from the load balancer to a VM in the scale set, you would go to the Azure Portal, find the load balancer of your scale set, examine the NAT rules, then connect using the NAT rule you want. For example, if there is a NAT rule on port 50000, you could SSH on port 50000 of the public IP to connect to that VM:

Deploy with uploading script file

```
rg="jjtest-rg"
az group create -l westeurope -n $rg
./az-group-deploy.sh -a vmss-custom-script-linux -l westeurope -g $rg
```

Deploy directly

```
rg="jjtest-rg"
az group create -l westeurope -n $rg
cd vmss-custom-script-linux 
az group deployment create -g $rg --template-file azuredeploy.json --parameters azuredeploy.parameters.json
```