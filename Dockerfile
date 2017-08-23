FROM node:6.9.2
# Much more reasonable in size (100MB instead of 700MB) but w/o apt other tools
# FROM node:6.10.3-alpine
# Using IBM container registry ibmnode
#FROM registry.au-syd.bluemix.net/ibmnode:latest

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Bundle app source
COPY . /usr/src/app

# Install app dependencies and build app
RUN npm install
RUN npm run build

# Environment variables
# In Kubernetes these should come from the Kube deployment config
#ENV WORKSPACE_ID <workspace ID>

EXPOSE 3000
CMD [ "npm", "start" ]
#CMD [ "ls", "/usr/src/app/"]
