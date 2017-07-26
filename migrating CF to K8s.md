# Notes on migrating the application from CF to Kubernetes Cluster
## Overall tasks
1. Get IBM Nodejs SDK container image
2. Build dockerfile with Car Dashboard application
3. Build Kubernetes Cluster
3. Configure Kubernetes secrects for Bluemix services
4. Deploy container image
5. Configure Ingress load balancer with static IP
6. Script the build and deployment in CD pipeline

* reference: [Bluemix Labs - Lab Kubernetes - Orchestrate your docker containers](https://github.com/lionelmace/bluemix-labs/tree/master/labs/Lab%20Kubernetes%20-%20Orchestrate%20your%20docker%20containers#step-5---get-and-build-the-application-code)

Creating a standard cluster from the CLI requires an infrastructure API key. To obtain the API key, read [this](https://console.bluemix.net/docs/containers/cs_cli_reference.html#cs_commands__cs_credentials_set)

API username is not the ID used to login to Infrastructure account. There is a separate API username that is found when viewing the API Key in the above page and also at the bottom of the [account overview page](https://control.softlayer.com/account/user/profile)
