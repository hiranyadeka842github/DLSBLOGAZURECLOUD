# The Technical Assignmet Exercise to create a Ghost Blog to available globally with required criterias
=======
Architecture with best possible design as per Geographical High Availbility and Disaster recovery options:

![image](https://user-images.githubusercontent.com/88244214/128779627-a632fa5b-096c-48b9-a93e-613eda9c343b.png)

![image](https://user-images.githubusercontent.com/88244214/128780506-cce90905-c786-42bc-b1ee-23acf9cf21cd.png)


### High Level Architecture design split into two secitoons:
        1. Azure Infrastructure Components
        2. Application Development Components
        
### Common methodologies to be used are  #####
        DEVOPS CI/CD Pipelines
        GITHUB REPOS
        
        
   For any changes to master branch Build & Release pipelines to be triggered automatically which will be based on approval for the corresponding feature branches used by multiple developers. For production deployment, there should be pre-deployment approvals in place which needs be approved by designated reviewers.

        Azure boards to be used for easy traccking, querying, reporting and graphical represntation of individual and related jobs & tasks.
        
  
  Entire design solution has been documented and demo with tested on Free account:

**Option1 to execute using powershell**:

1.	Please go to GITHUB link) and download the powershell script:
	        https://github.com/hiranyadeka842github/DLSBLOGAZURECLOUD/blob/master/azureghostdeploytwoglobalregions.ps1
2.	az login
4.	Then run the script which will deploy all resources(Either Pipelines from azure devops or on local computer):
5.	Once tested delete the entire resource group:
                az group delete -n ghostappldeka-rg

**Option2 to deploy using ARM templates**:

1. ARM template deploy for first website resources in One region(Important note: Please make sure to use the resource group name on deployment fron Azure portal: ghostappldeka-rg for all 4 ARM template deployments):

      https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhiranyadeka842github%2FDLSBLOGAZURECLOUD%2Fmaster%2FAPP_GEOREGION1_ARM.json
      
2. ARM to deploy second website resources in Second region(Here also, please use the same resource group name on deployment: ghostappldeka-rg):

      https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhiranyadeka842github%2FDLSBLOGAZURECLOUD%2Fmaster%2FAPP_GEOREGION2_ARM.json

3. Azure Front door resource pointing to website1 and website2(404 error):

https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhiranyadeka842github%2FDLSBLOGAZURECLOUD%2Fmaster%2FARMFRONTDOOR.json

4. Azure traffic manager profile pointing to website1 and website2(404 error):

https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhiranyadeka842github%2FDLSBLOGAZURECLOUD%2Fmaster%2FARMTRAFFICMGR.json

5. From Cloudshell to delete all resources:
	az group delete -n ghostappldeka-rg

This is just a DEMO to show the resources as per design getting created and initial idea is displayed here. In customer's environment Linked or nested template can be created and also should be run through CI/CD pipelines.

Powershell script output which failed for second website resources and reran after corrections:

https://github.com/hiranyadeka842github/DLSBLOGAZURECLOUD/blob/master/ghostapp_powershelldeployoutput_08082021.txt


ANOETHER REPOSITORY to use similar concept where Python app will be created and will be run Ubuntu using shell scripting, which will be deployed on VMSS. The script has option to conintue the blog job which will increase CPU utilization and then automaticallly new VM instances will get increased:

https://github.com/hiranyadeka842github/BLOGDEMOONLY



