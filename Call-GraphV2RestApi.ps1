function New-GraphV2AuthToken
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
        # https://docs.microsoft.com/en-us/graph/auth-v2-service?view=graph-rest-beta

        # auth URIs
        $aadUri = 'https://login.microsoftonline.com/{0}/oauth2/v2.0/token'
        $scope = 'https://graph.microsoft.com/.default'
 
        # load the web assembly and encode parameters
        $null = [Reflection.Assembly]::LoadWithPartialName('System.Web')
        $encodedClientAppSecret = [System.Web.HttpUtility]::UrlEncode($AadClientAppSecret)
        $encodedScope = [System.Web.HttpUtility]::UrlEncode($scope)
 
        # construct and send the request
        $tenantAuthUri = $aadUri -f $AadTenantId
        $headers = @{
            'Content-Type' = 'application/x-www-form-urlencoded';
        }
        $bodyParams = @(
            "grant_type=client_credentials",
            "client_id=$AadClientAppId",
            "client_secret=$encodedClientAppSecret",
            "scope=$encodedScope"
        )
        $body = [System.String]::Join("&", $bodyParams)
 
        Invoke-RestMethod -Uri $tenantAuthUri -Method POST -Headers $headers -Body $body
    }
}

function List-TeamsJoined
{
    [CmdletBinding()]
    param
    (
        $user,
        $Token
    )
    process
    {
        # construct headers
        $headers = @{
            'Host' = 'graph.microsoft.com'
            'Content-Type' = 'application/json';
            'Authorization' = "Bearer $Token";
            }
      
        $baseServiceUri = "https://graph.microsoft.com/beta/users/{0}/joinedTeams"
        $serviceUri = $baseServiceUri -f $user
 
        # call the API
        Invoke-RestMethod -Uri $serviceUri -Method Get -Headers $headers
    }
}

function Create-Team
{
    [CmdletBinding()]
    param
    (        
        $TeamName,
        $TeamOwner,
        $Token
    )
    process
    {
        # https://docs.microsoft.com/en-us/graph/api/team-post?view=graph-rest-beta

        $requestBodyAsText = '
            "template@odata.bind": "https://graph.microsoft.com/beta/teamsTemplates/standard",
            "displayName": "{0}",
            "description": "popis",            
            "owners@odata.bind": [
              "https://graph.microsoft.com/beta/users(''{1}'')"
            ]
          '
        $requestBodyAsText = $requestBodyAsText -f $TeamName, $TeamOwner
        $requestBodyAsJson = "{" + $requestBodyAsText + "}"

        # construct headers
        $headers = @{
            'Host' = 'graph.microsoft.com'
            'Content-Type' = 'application/json';
            'Authorization' = "Bearer $Token";
            }
      
        $baseServiceUri = "https://graph.microsoft.com/beta/teams"
        $serviceUri = $baseServiceUri 
 
        # call the API
        Invoke-RestMethod -Uri $serviceUri -Method Post -Headers $headers -Body $requestBodyAsJson
    }
}

function Create-TeamFromTemplate
{
    [CmdletBinding()]
    param
    (        
        $TeamName,
        $TeamOwner,
        $Token
    )
    process
    {
        # templates https://docs.microsoft.com/en-us/microsoftteams/healthcare/healthcare-templates?WT.mc_id=email
        $requestBodyAsText = '{ 
            "template@odata.bind": "https://graph.microsoft.com/beta/teamsTemplates/healthcareHospital",
            "DisplayName": "Contoso Hospital3",
            "Description": "Team for all staff in Contoso Hospital",
            "owners@odata.bind": [
                "https://graph.microsoft.com/beta/users(''5a9589a0-01d2-4716-bc4d-0c7e329b6295'')"
              ],
            "Channels": [
              {
                "displayName": "Ambulatory",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Anesthesiology",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Cardiology",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "CCU",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Ear, Nose, and Throat",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Emergency Care",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Family Medicine",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Gynecology",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "ICU",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Mother-Baby",
                "IsFavoriteByDefault": false
              }, 
              {
                "displayName": "Neonatal",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Neurology",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Oncology",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Ophthalmology",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "PACU",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Psychiatric",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Radiology",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Rehabilitation",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Surgical",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Urology",
                "IsFavoriteByDefault": false
              },
              {
                "displayName": "Women’s Health",
                "IsFavoriteByDefault": false
              }
            ],
            "Apps": [
              {
                "Id": "1542629c-01b3-4a6d-8f76-1938b779e48d"
              }
            ]
            }
          '        
        $requestBodyAsJson = $requestBodyAsText

        # construct headers
        $headers = @{
            'Host' = 'graph.microsoft.com'
            'Content-Type' = 'application/json';
            'Authorization' = "Bearer $Token";
            }
      
        $baseServiceUri = "https://graph.microsoft.com/beta/teams"
        $serviceUri = $baseServiceUri 
 
        # call the API
        Invoke-RestMethod -Uri $serviceUri -Method Post -Headers $headers -Body $requestBodyAsJson
    }
}

# Setup credential - Tenant, ApplicationID, Secret
$ClientId       = "0a3ef857-a0a1-4b96-baae-e33dff01e3aa" 
$ClientSecret   = "<SECRET>"  
$TenantId      = "37c4d4f6-bfdb-4bfb-83be-d2520f4062c2"

$authResult = New-GraphV2AuthToken -AadClientAppId $ClientId -AadClientAppSecret $ClientSecret -AadTenantId $TenantId

List-TeamsJoined -User "5a9589a0-01d2-4716-bc4d-0c7e329b6295" `
    -Token $authResult.access_token

Create-TeamFromTemplate -TeamName "Test5" -TeamOwner "5a9589a0-01d2-4716-bc4d-0c7e329b6295" `
    -Token $authResult.access_token  