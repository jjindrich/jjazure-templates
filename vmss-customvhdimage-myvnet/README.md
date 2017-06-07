# Deploy a VM Scale Set with managed disks based on custom VHD image

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjjindrich%2Fjjazure-templates%2Fmaster%2Fvmss-customvhdimage-myvnet%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fjjindrich%2Fjjazure-templates%2Fmaster%2Fvmss-customvhdimage-myvnet%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to deploy a VM Scale Set with managed disk based on custom VHD image. Windows and Linux vhd is supported. To connect from the load balancer to a VM in the scale set, you would go to the Azure Portal, find the load balancer of your scale set, examine the NAT rules, then connect using the NAT rule you want. For example, if there is a NAT rule on port 50000, you could RDP on port 50000 of the public IP to connect to that VM:

PARAMETER RESTRICTIONS
======================

sourceImageVhdUri must be link to existing vhd image stored on storage account.