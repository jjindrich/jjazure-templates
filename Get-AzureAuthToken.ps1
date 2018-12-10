# Get Azure Authentication Token to access Azure API
# https://docs.microsoft.com/en-us/rest/api/azure/
# Create App registration in AAD and assign permission to Azure resource you want to manage it

# Setup credential - Tenant, ApplicationID, Secret
$ClientId       = "68e48a72-7948-4471-af92-2a6bf270636b" 
$ClientSecret   = "SECRET"  
$TenantId      = "5bf07991-ef59-43e0-861c-ab35a6cfc932"

$TokenEndpoint = {https://login.windows.net/{0}/oauth2/token} -f $TenantID 
$ARMResource = "https://management.azure.com/";
#$ARMResource = "https://management.core.windows.net/";

$Body = @{
        'resource'= $ARMResource
        'client_id' = $ClientId
        'grant_type' = 'client_credentials'
        'client_secret' = $ClientSecret
}

$params = @{
    ContentType = 'application/x-www-form-urlencoded'
    Headers = @{'accept'='application/json'}
    Body = $Body
    Method = 'Post'
    URI = $TokenEndpoint
}

$token = Invoke-RestMethod @params

#$token 
#$token | select @{L='Expires';E={[timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($_.expires_on))}} | fl *

echo "Copy/paste your access token:"
$token.access_token

# Sample to start VM
# https://docs.microsoft.com/en-us/rest/api/compute/virtualmachines/start
# POST https://management.azure.com/subscriptions/82fb79bf-ee69-4a57-a76c-26153e544afe/resourceGroups/JJDevV2-VM/providers/Microsoft.Compute/virtualMachines/jjdevv2addc/start?api-version=2018-06-01