function New-AzureRmAuthToken
{
    <#
        .SYNOPSIS
        Creates a new authentication token for use against Azure RM REST API operations.
 
        .DESCRIPTION
        Creates a new authentication token for use against Azure RM REST API operations. This uses client/secret auth (not certificate auth).
        The returned output contains the OAuth bearer token and it's properties.
 
        .PARAMETER AadClientAppId
        The AAD client application ID.
 
        .PARAMETER AadClientAppSecret
        The AAD client application secret
 
        .PARAMETER AadTenantId
        The AAD tenant ID.
 
        .EXAMPLE
        New-AzureRmAuthToken -AadClientAppId '<app id>' -AadClientAppSecret '<app secret>' -AadTenantId '<tenant id>' 
    #>
 
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, HelpMessage='Please provide the AAD client application ID.')]
        [System.String]
        $AadClientAppId,
 
        [Parameter(Mandatory=$true, HelpMessage='Please provide the AAD client application secret.')]
        [System.String]
        $AadClientAppSecret,
 
        [Parameter(Mandatory=$true, HelpMessage='Please provide the AAD tenant ID.')]
        [System.String]
        $AadTenantId
    )
 
    Process
    {
        # auth URIs
        $aadUri = 'https://login.microsoftonline.com/{0}/oauth2/token'
        $resource = 'https://management.core.windows.net'
 
        # load the web assembly and encode parameters
        $null = [Reflection.Assembly]::LoadWithPartialName('System.Web')
        $encodedClientAppSecret = [System.Web.HttpUtility]::UrlEncode($AadClientAppSecret)
        $encodedResource = [System.Web.HttpUtility]::UrlEncode($Resource)
 
        # construct and send the request
        $tenantAuthUri = $aadUri -f $AadTenantId
        $headers = @{
            'Content-Type' = 'application/x-www-form-urlencoded';
        }
        $bodyParams = @(
            "grant_type=client_credentials",
            "client_id=$AadClientAppId",
            "client_secret=$encodedClientAppSecret",
            "resource=$encodedResource"
        )
        $body = [System.String]::Join("&", $bodyParams)
 
        Invoke-RestMethod -Uri $tenantAuthUri -Method POST -Headers $headers -Body $body
    }
}

function Start-AzureStreamAnalyticsJob
{
    [CmdletBinding()]
    param
    (
        $JobName,
        $SubscriptionID,
        $ResourceGroupName,
        $Token
    )
    process
    {
        # construct request body object
        $requestBody = [pscustomobject]@{            
            outputStartMode = "LastOutputEventTime"
        }
         
        # convert request body object to a JSON string
        $requestBodyAsJson = ConvertTo-Json -InputObject $requestBody -Depth 2
         
        # construct headers
        $headers = @{
            'Host' = 'management.azure.com'
            'Content-Type' = 'application/json';
            'Authorization' = "Bearer $Token";
            }
         
        # construct the resource URI
        
        $baseServiceUri = "https://management.azure.com/subscriptions/{0}/resourceGroups/{1}/providers/Microsoft.StreamAnalytics/streamingjobs/{2}/start?api-version=2015-10-01"
        $serviceUri = $baseServiceUri -f $SubscriptionID, $ResourceGroupName, $JobName
 
        # call the API
        Invoke-RestMethod -Uri $serviceUri -Method POST -Headers $headers -Body $requestBodyAsJson
    }
}

function Stop-AzureStreamAnalyticsJob
{
    [CmdletBinding()]
    param
    (
        $JobName,
        $SubscriptionID,
        $ResourceGroupName,
        $Token
    )
    process
    {
        # construct headers
        $headers = @{
            'Host' = 'management.azure.com'
            'Content-Type' = 'application/json';
            'Authorization' = "Bearer $Token";
            }
         
        # construct the resource URI
        
        $baseServiceUri = "https://management.azure.com/subscriptions/{0}/resourceGroups/{1}/providers/Microsoft.StreamAnalytics/streamingjobs/{2}/stop?api-version=2015-10-01"
        $serviceUri = $baseServiceUri -f $SubscriptionID, $ResourceGroupName, $JobName
 
        # call the API
        Invoke-RestMethod -Uri $serviceUri -Method POST -Headers $headers
    }
}

# Setup credential - Tenant, ApplicationID, Secret
$ClientId       = "68e48a72-7948-4471-af92-2a6bf270636b" 
$ClientSecret   = "SECRET"  
$TenantId      = "5bf07991-ef59-43e0-861c-ab35a6cfc932"

$authResult = New-AzureRmAuthToken -AadClientAppId $ClientId -AadClientAppSecret $ClientSecret -AadTenantId $TenantId

Stop-AzureStreamAnalyticsJob -JobName "job" `
    -SubscriptionID "subscription" `
    -ResourceGroupName "RG" `
    -Token $authResult.access_token