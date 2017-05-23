#!/bin/bash
# Create services
# conversation
cf create-service conversation free my-conversation-service
# speech-to-text
cf create-service speech_to_text standard speech-to-text-service
# text-to-speech
cf create-service text_to_speech standard text-to-speech-service

# Push app
export CF_APP_NAME="staging-$CF_APP"
cf push "${CF_APP_NAME}" -n ${CF_APP_NAME}
export APP_URL=http://$(cf app $CF_APP_NAME | grep urls: | awk '{print $2}')
# View logs
#cf logs "${CF_APP_NAME}" --recent
