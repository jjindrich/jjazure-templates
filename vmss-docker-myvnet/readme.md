# Azure Virtual Machine ScaleSet running Docker container in custom virtual network
This script creates VMSS running Docker image stored in Azure Container Registry (ACR) in custom virtual network.

Using Docker Extension is deprecated ! see https://github.com/Azure/azure-docker-extension/wiki/Deprecation-Notice

We have to use custom script extension to install deploy it.

## Deploy VMSS in virtual network with Azure CLI

```sh
rg=<YOUR-NAME>
az group create -n $rg -l westeurope
az storage account create -l westeurope --sku "Standard_LRS" -g $rg -n jjstoragescript

./az-group-deploy.sh -g $rg -l westeurope -s jjstoragescript -a vmss-docker-myvnet
```

## Upgrade cluster
Now go to Azure Portal and check Instances. There is waiting update, click Upgrade. Our VMSS is configured as Manual upgrade.

![VMSS waiting upgrade](media/vmss-upgrade.png)
