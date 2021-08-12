#!/bin/bash

###RUN
webapp1="dslcompanydeka3030app1"
webapp2="dslcompanydeka3030app2"
frondoor="dslcompanydeka3030global"
ttfkmanager="aztrafficghostblogdeka1"
rggroup="ghostappldeka-rg"

### Create resource group if not exists

az group list --query "[?location=='eastus']"|grep -i "${rggroup}" > /dev/null
if [ $? -ne 0 ]
then
echo "Creating the resource group"
az group create -n $rggroup -l eastus
echo "Resource group Created"
fi

echo " All resources will be created inside resource group ghostappldeka-rg"

## Deploy the ARM template for complete end to end build task for webapp1 in GEOREGION1 (eastus)
az webapp list --query "[?state=='Running']"|grep -i $webapp1 >/dev/null
if [ $? -ne 0 ]
then
echo "Deploying the $webapp1 for Ghost application build on Azure app servuces"
az deployment group create --resource-group $rggroup --template-file APP_GEOREGION1_ARM.json
else
echo "The webapp name $webapp1 was already used by someone, please have a look manually and delete the resources if it was created on your subscription"
fi

echo "Wating for 30 seconds for next deployment"
sleep 30

## Deploy the ARM template for complete end to end build task for webapp2 in GEOREGION2 (West Europe)
az webapp list --query "[?state=='Running']"|grep -i $webapp2 > /dev/null
if [ $? -ne 0 ]
then
echo "Deploying the $webapp2 for Ghost application build on Azure app services"
az deployment group create --resource-group $rggroup --template-file APP_GEOREGION2_ARM.json
else
echo "The webapp name $webapp2 was already used by someone, please have a look manually and delete the resources if it was created on your subscription"
exit
fi

echo "Wating for 30 seconds for next deployment"
sleep 30
## Deploy ARM tempate for frontdoor
echo "Creating frontdoor with the wbeapps as backend pool endpoints"
az deployment group create --resource-group $rggroup --template-file ARMFRONTDOOR.json

echo "Wating for 30 seconds for next deployment"
sleep 30

## Deploy ARM template for trafic manager profile

az deployment group create --resource-group $rggroup --template-file ARMTRAFFICMGR.json

################################################
echo "All resources have been created"
echo "You can try accesing the all 4 weblinks.... frontdoor and trafic manager is throwing 404 error on my system. Needs to troubleshoot"

################################################

