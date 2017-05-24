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
Clone the repository.
Create a CD pipeline with the existing repository `https://github.com/iwinoto/car-dashboard.git`.
In the deploy stage, set the deploy script to
```sh
#!/bin/bash
./cf-deploy.sh iw-$CF_APP-$CF_SPACE
```

## Script
  1. Bluemix quick view of CF runtimes
  1. Bluemix catalogue
  1. Watson services
  1. Going to create an application using the Watson Conversation service. It will be used to create a virtual assistant for a smart car dashboard.
  1. Create an instance of the Watson Conversation service and call it `my-conversation-service`
  1. Open the conversation service dialogue
  1. We already have a conversation model built that has been exported to a JSON file.
  1. We'll import the JSON to create a new workspace.
  1. A conversation service instance can have multiple conversation models with sets of intents, entities and dialogues. Each of these represents a conversation workspace.
  1. An application connects to a particular conversation workspace.
  1. Our application has conversations to control a car. We'll get the WORKSPACE_ID to add to our application.
  1. We use the DevOps Toolchain to deploy the application.
  1. Following good 12-Factor app principles, we set the WORKSPACE_ID in the manifest file and commit the change to our source code repository.
  1. Run the app and have a conversation
  1. Ask for petrol stations
  1. Ask for gas stations
    * **Note** that Petrol is not understood. The conversation needs to be localised for AUS.
  1. Open the Conversation dashboard
  1. In the metrics view we can see the conversations that have been had.
  1. You can use this view to modify the model.
  1. Find the Petrol conversation and add 'Petrol station' as an example (synonym) for `@amenity:gas` entity.
  1. The model will be modified, which may take some time.
  1. We can test the new in the same view.
