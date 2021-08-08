$webapp1 = "dslcompanydeka3030app1"
$webapp2 = "dslcompanydeka3030app2"
$frondoor = "dslcompanydeka3030global"
$ttfkmanager = "aztrafficghostblogdeka1"
$rggroup = "ghostappldeka-rg"

### Create resource group if not exists
az group list -n ghostappldeka-rg >$NULL
if ("$?" -eq "$False") {
echo "Creating the resource group"
az group create -n $rggroup -l eastus
echo "Resource group Created"
}

## Deploy the ARM template for complete end to end build task for webapp1 in GEOREGION1 (eastus)
az webapp list --query "[?state=='Running']"|findstr $webapp1 >$NULL
if ("$?" -eq "$False") {
echo "Deploying the $webapp1 for Ghost application build on Azure app servuces"
az deployment group create --resource-group $rggroup --template-uri https://raw.githubusercontent.com/hiranyadeka842github/DLSBLOGAZURECLOUD/master/APP_GEOREGION1_ARM.json
}
else
{
echo "The webapp name $webapp1 was already used by someone, please have a look manually and delete the resources if it was created on your subscription"
##exit
}

echo "Wating for 30 seconds for next deployment"
Start-Sleep -Seconds 30

## Deploy the ARM template for complete end to end build task for webapp2 in GEOREGION2 (West Europe)
az webapp list --query "[?state=='Running']"|findstr $webapp2 >$NULL
if ("$?" -eq "$False") {
echo "Deploying the $webapp2 for Ghost application build on Azure app services"
az deployment group create --resource-group $rggroup --template-uri https://raw.githubusercontent.com/hiranyadeka842github/DLSBLOGAZURECLOUD/master/APP_GEOREGION2_ARM.json
}
else
{
echo "The webapp name $webapp2 was already used by someone, please have a look manually and delete the resources if it was created on your subscription"
##exit
}

echo "Wating for 30 seconds for next deployment"
Start-Sleep -Seconds 30
## Deploy ARM tempate for frontdoor
echo "Creating frontdoor with the wbeapps as backend pool endpoints"
az deployment group create --resource-group $rggroup --template-uri https://raw.githubusercontent.com/hiranyadeka842github/DLSBLOGAZURECLOUD/master/ARMFRONTDOOR.json

echo "Wating for 30 seconds for next deployment"
Start-Sleep -Seconds 30

## Deploy ARM template for trafic manager profile

az deployment group create --resource-group $rggroup --template-uri https://raw.githubusercontent.com/hiranyadeka842github/DLSBLOGAZURECLOUD/master/ARMTRAFFICMGR.json

################################################
echo "All resources have been created"
echo "You can try accesing the all 4 weblinks.... frontdoor and trafic manager is throwing 404 error on my system. Needs to troubleshoot"

################################################

