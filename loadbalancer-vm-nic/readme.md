# Assign VM NIC to Azure Load balancer

Ansible creates Azure Load balancer with backend pool definition. But cannot assign VM NIC adapter into pool.
It's related to this issue https://github.com/ansible/ansible/issues/37734

This sample assumes Load balancer (jjlb) is created and associated with AvailabilitySet (jjvmset).

![Resource group](media\resources.png)

This template assigns VM NIC adapter to Load balancer. 

## Load balacer before update

![Status before](media\before.png)

To change check parameters and run this command.

```bash
az group deployment create -g <GROUP> --template-file deploy.json --parameters params.json
```

## Load balacer after update

![Status after](media\after.png)