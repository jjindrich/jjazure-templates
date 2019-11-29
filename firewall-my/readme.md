# Firewall setup on my vnet

## Vnet definition

Hub Vnet JJDevV2Network 10.3.0.0/16

- AzureFirewallSubnet 10.3.252.0/24
- GatewaySubnet 10.3.0.0/29
- DmzInfra 10.3.250.0/24
- DmzWeb 10.3.1.0/24

Spoke Vnet JJDevV2Network 10.4.0.0/16

- DmzApp 10.4.1.0/24

Vnet connected via peering JJDevV2Network <-> JJDevV2Network

Vnet JJDevV2Network connected to onprem via JJDevV2Network S2S VPN connection to local network 10.1.0.0/16

## Deploy firewall

Call deploy.azcli part to deploy firewall and routes