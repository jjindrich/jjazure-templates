# Deploy a VM Scale Set of Windows VMs with a custom script extension

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjjindrich%2Fazure-templates%2Fmaster%2Fvmss-custom-script-linux%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

This template allows you to deploy a VM Scale Set of Linux VMs with a custom script run on each VM. To connect from the load balancer to a VM in the scale set, you would go to the Azure Portal, find the load balancer of your scale set, examine the NAT rules, then connect using the NAT rule you want. For example, if there is a NAT rule on port 50000, you could SSH on port 50000 of the public IP to connect to that VM:

Sample custom script install Mindnight Commander and simple Docker container with web server.
You can try to access ssh session on ports beginning 50000. Web app is running on load balanced port 80.

If you want to manage Docker it's much easier with <a href="https://docs.microsoft.com/en-us/azure/virtual-machines/linux/dockerextension">Azure Docker VM Extension</a>.

PARAMETER RESTRICTIONS
======================

vmssName must be 3-61 characters in length. It should also be globally unique across all of Azure. If it isn't globally unique, it is possible that this template will still deploy properly, but we don't recommend relying on this pseudo-probabilistic behavior.
instanceCount must be 100 or less.