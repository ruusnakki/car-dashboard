# A 30 minute demonstration script

## Objectives
In 30 minutes, convey how IBM Bluemix allows the ease of creating engaging end user applications using natural language cognitive technologies.

The user interface application development is not important, but access to highly functional cognitive services to enable the user interface is.

Most of this demo will use the Bluemix Web Console. At the time of writing, the Continous Delivery service is only available in US-South region. The deployment job can be configured to deploy to any accessible Bluemix Region with access to the required services.

  * DevOps Toolchain or not?
  * Create services from catalogue? OR from deploy script?
  * How to set WORKSPACE_ID?
    * create conversation service
    * import workspace
    * get WORKSPACE_ID
    * set environment variable in manifest file
    * push application from command line OR commit and push to github and let pre-configured toolchain deploy.

## Audience
Because of the length of time, the script assumes that the audience has a knowledge of the differences between PaaS and IaaS and knows the basic value proposition of Bluemix, its public regions and deployment options. A good persona approximation is an IBM Hybrid Cloud seller.

The script was created for the IBM Deal Maker team to be used at an event in Sydney on Wednesday 24 May, 2017.

## Preconditions
set cf target to demo target region. For Sydney:
```sh
bx api https://api.au-syd.bluemix.net
```
Login using `--sso` option for federated id. This will require nagivating to a web page to get a one time passcode. During the interactive login, select the organisation and space. Alternatively, login in non-interactively using the -o and -s parameters to specify the organisation and space.
```sh
bx login --sso -o iwinoto@au1.ibm.com -s bluemix-demo
```

## Preparation
