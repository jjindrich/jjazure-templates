# Azure VM with Bulding Blocks
This sample shows how to run create new Virtual Machine with Azure Building Blocks.
Documentation on this <a href="https://aka.ms/azbbv2">link</a>.
It's PREVIEW...                    

## Prepare environment
Install Azure Bulding Blocks on local machine.
```
npm install -g @mspnp/azure-building-blocks
```

## Deploy VM
Run this command. This generates .json file to deploy it with ARM deployment automatically.
```
azbb -g jjtest -s <subscription_id> -l westeurope -p deploy.json --deploy

```