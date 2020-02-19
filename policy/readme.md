# JJAzure Policy definitions

## Deploy Azure Policy definitions

It deploys Azure Policy definitions with Category Network.
Next setup assignment based on you requirements - to subscriptions or management groups.

This policy allows you **control public IP configured on Azure PaaS services**.

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

Missing policy for following PaaS services

- Service Bus
- Container Registry
- EventHub
- CosmosDB
- App Service

## Report audit logs

Configure Activity log Diagnostics settings to send data into Log Analytics. Than run query.

```kusto
AzureActivity 
| where Category == 'Policy' and Level != 'Informational' 
| extend p=todynamic(Properties) 
| extend policies=todynamic(tostring(p.policies)) 
| mvexpand policy = policies 
| where p.isComplianceCheck == 'False'
```