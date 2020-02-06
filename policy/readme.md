# JJAzure Policy definitions

## Deploy Azure Policy definitions

It deploys Azure Policy definitions with Category Network. 
Next setup assignment based on you requirements - to subscriptions or management groups.

```bash
az policy definition create --name 'audit-sqlserver-fw'  \
    --mode Indexed --metadata 'category=Network' \
    --display-name 'SQL server should have empty firewall ip addresses' \
    --description 'This policy audits any SQL server with allowed firewall ip addresses.' \
    --rules 'sql-fw.rules.json' --params 'sql-fw.parameters.json'

az policy definition create --name 'audit-keyvault-fw' \
    --mode Indexed --metadata 'category=Network' \
    --display-name 'Key Vault should have empty firewall ip addresses' \
    --description 'This policy audits any Key Vault with allowed firewall ip addresses.' \
    --rules 'keyvault-fw.rules.json' --params 'keyvault-fw.parameters.json'

az policy definition create --name 'audit-storage-fw' \
    --mode Indexed --metadata 'category=Network' \
    --display-name 'Storage should have empty firewall ip addresses' \
    --description 'This policy audits any Storage with allowed firewall ip addresses.' \
    --rules 'storage-fw.rules.json' --params 'storage-fw.parameters.json'
```