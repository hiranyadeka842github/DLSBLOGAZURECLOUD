# The Technical Assignmet Exercise to create a Ghost Blog to available globally with required criterias
=======
Architecture with best possible degion as per Geographical High Availbility and Disaster recovery options:

![image](https://user-images.githubusercontent.com/88244214/128779627-a632fa5b-096c-48b9-a93e-613eda9c343b.png)


### High Level Architecture design split into two secitoons:
        1. Azure Infrastructure Components
        2. Application Development Components
        
### Common methodologies to be used are  #####
        DEVOPS CI/CD Pipelines
        GITHUB REPOS
      
      ![image](https://user-images.githubusercontent.com/88244214/128780424-068c40b6-06e4-4c2d-92b1-726e1ba60efc.png)

        
        
  Entire design solution has been documented and demo with tested on Free account:

1. ARM template deploy for first website resources in One region(Important note: Please make sure to use the resource group name on deployment fron Azure portal: ghostappldeka-rg for all 4 ARM template deployments):

      https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhiranyadeka842github%2FDLSBLOGAZURECLOUD%2Fmaster%2FAPP_GEOREGION1_ARM.json
      
2. ARM to deploy second website resources in Second region(Here also, please use the same resource group name on deployment: ghostappldeka-rg):

      https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhiranyadeka842github%2FDLSBLOGAZURECLOUD%2Fmaster%2FAPP_GEOREGION2_ARM.json

3. Azure Front door resource pointing to website1 and website2(404 error):

        https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhiranyadeka842github%2FDLSBLOGAZURECLOUD%2Fmaster%2FARMFRONTDOOR.json

4. Azure traffic manager profile pointing to website1 and website2(404 error):

        https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhiranyadeka842github%2FDLSBLOGAZURECLOUD%2Fmaster%2FARMTRAFFICMGR.json






