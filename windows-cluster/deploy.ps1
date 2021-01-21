$rg = 'JJDevV2-VM-CLUSTER'
az group create -n $rg -l westeurope
az deployment group create -g $rg --template-file deploy.json --parameters deploy.parameters.json