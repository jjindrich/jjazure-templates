# JJ Azure Resource Manager Templates
This repo contains Azure Resource Manager templates created by JJ.

## Deploy templates
You can deploy these samples directly through the Azure Portal or by using the scripts supplied in the root of the repo.

To deploy a sample using the Azure Portal, click the **Deploy to Azure** button found in the README.md of each sample.

To deploy the sample via the command line (using [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/overview) or the [Azure CLI 1.0](https://docs.microsoft.com/en-us/azure/cli-install-nodejs)) you can use the scripts below.

Simply execute the script and pass in the folder name of the sample you want to deploy.  

For example:

### PowerShell
```PowerShell
.\Deploy-AzureResourceGroup.ps1 -ResourceGroupLocation 'eastus' -ArtifactStagingDirectory '[foldername]'
or
.\Deploy-AzureResourceGroup.ps1 -ResourceGroupLocation 'eastus' -ArtifactStagingDirectory '[foldername]' -ResourceGroup 'mygroup'
```
### Bash

Please ensure that you have [node and npm](https://docs.npmjs.com/getting-started/installing-node), [jq](https://stedolan.github.io/jq/download/) and [azure-cli](https://docs.microsoft.com/en-us/azure/cli-install-nodejs) installed.

```bash
./az-group-deploy.sh -a [foldername] -l eastus
```

- If you see the following error: "syntax error near unexpected token `$'in\r''", run this command: 'dos2unix azure-group-deploy.sh'.
- If you see the following error: "jq: command not found", run this command: "sudo apt install jq".
- If you see the following error: "node: not found", install node and npm.
- If you see the following error: "azure-group-deploy.sh is not a command", make sure you run "chmod +x azure-group-deploy.sh".

## Uploading Artifacts

If the sample has artifacts that need to be "staged" for deployment (Configuration Scripts, Nested Templates, DSC Packages) then set the upload switch on the command.
You can optionally specify a storage account to use, if so the storage account must already exist within the subscription.  If you don't want to specify a storage account
one will be created by the script or reused if it already exists (think of this as "temp" storage for AzureRM).

### PowerShell
```PowerShell
.\Deploy-AzureResourceGroup.ps1 -ResourceGroupLocation 'eastus' -ArtifactStagingDirectory '201-vm-custom-script-windows' -UploadArtifacts 
```

### Bash
```bash
./azure-group-deploy.sh -a [foldername] -l eastus -u
```
### Bash directly
This bash command excutes deployment directly without uploading artifacts.

```bash
az group create -n jjtest -l westeurope
az group deployment create -g jjtest --template-file azuredeploy.json --parameters azuredeploy.parameters.json
```