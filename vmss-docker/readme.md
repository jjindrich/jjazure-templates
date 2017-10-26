# Azure Virtual Machine ScaleSet with docker
This sample shows how to run docker image / compose on VMSS in Azure.

## Using Docker extension
```
                {
                  "name": "DockerExtension",
                  "properties": {
                    "publisher": "Microsoft.Azure.Extensions",
                    "type": "DockerExtension",
                    "typeHandlerVersion": "1.0",
                    "autoUpgradeMinorVersion": true,
                    "protectedSettings": {                        
                        "environment": {
                            "JJ_PASSWORD": "[parameters('adminPassword')]"
                              }
                        },
                    "settings": {
                        "compose": {
                            "web": {
                                "image": "yeasy/simple-web",
                                    "ports": ["80:80"],                                    
                                    "environment": ["JJ_PASSWORD"]
                                }                 
                            }
                        }
                    }                    
                },
```