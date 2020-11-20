# Azure Shared Disk

Shared Disk https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-shared-enable

Create Ultra SSD disk

```powershell
az disk create -g sharedisk-rg -n shdiskdataz1 --size-gb 1024 -l westeurope --zone 1 --sku UltraSSD_LRS --max-shares 5 --disk-iops-read-write 2000 --disk-mbps-read-write 200 --disk-iops-read-only 100 --disk-mbps-read-only 1
```

