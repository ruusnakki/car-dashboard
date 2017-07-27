# FROM node:6.9.2
# Much more reasonable in size (100MB instead of 700MB)
FROM node:6.10.3-alpine

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
