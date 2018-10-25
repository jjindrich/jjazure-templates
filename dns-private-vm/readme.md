# Virtual Network with Azure DNS Private zone

## Deploy template

```bash
az group create -n DNS-TEST -l westeurope
az group deployment create -g FW-TEST --template-file deploy-vnetdns.json --parameters deploy-vnetdns-params.json
```