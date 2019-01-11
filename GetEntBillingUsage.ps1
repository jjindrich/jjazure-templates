# Azure Billing API for Enterprise
# ! allow authentication with Billing API key
# https://docs.microsoft.com/en-us/azure/billing/billing-enterprise-api

$token='billing_api_key'
$enrollment='enrollment_number'
$period='201901'
Invoke-WebRequest `
    -Uri https://consumption.azure.com/v3/enrollments/$enrollment/usagedetails/download?billingPeriod=$period `
    -Method Get -Headers @{ "Authorization" = "Bearer $token" } `
    -OutFile usage.csv