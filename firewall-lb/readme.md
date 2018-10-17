# Virtual Network with Azure Firewall

## Provision Vnet with firewall
Template will create new vnet with subnets and activate Azure Firewall on backend subnet.
Template created base on this sample https://docs.microsoft.com/en-us/azure/firewall/deploy-template

```bash
az group create -n FW-TEST -l westeurope
az group deployment create -g FW-TEST --template-file deploy-vnetfw.json --parameters deploy-vnetfw-params.json
```
KNOWN ISSUE: There is hardcoded public IP address in firewall NAT rule. You have to redeploy with correct IP address.

## Create VM with web server
Webserver is created with cloud init - from file vm-init.txt

create with ARM template with Cloud-init (must be allowed *ubunyu.com on network)
```bash
az group create -n FW-TEST-VM -l westeurope
az group deployment create -g FW-TEST-VM --template-file deploy-vm.json --parameters deploy-vm-params.json
```

or create with script and open HTTP on NSG manually
```bash
az group create -n FW-TEST-VM -l westeurope
az vm create -g FW-TEST-VM -n jjvm --custom-data vm-init.txt --image UbuntuLTS --subnet $(az network vnet subnet show -g FW-TEST --vnet-name jjtestfw-vnet -n backend -o tsv --query id) --authentication-type password --admin-username jj --admin-password Azure-1234567890
```

## Publish web server with Azure Application Gateway
Create Application Gateway in specific vnet subnet. On this subnet cannot be Azure Firewall activated (routing is disabled). After created, simply publish web server.

```bash
az network application-gateway create  -g FW-TEST-VM1 -l westeurope -n jjtestfw-appgw --capacity 2 --sku Standard_Medium --frontend-port 80 --http-settings-port 80 --http-settings-protocol http --routing-rule-type Basic --public-ip-address-allocation Dynamic --subnet $(az network vnet subnet show -g FW-TEST --vnet-name jjtestfw-vnet -n appgw -o tsv --query id) --servers 10.1.0.4
```