#!/bin/bash

CF_CMD="bx cf"
echo "cf command is " $CF_CMD
# Create services
# conversation
$CF_CMD create-service conversation free my-conversation-service
# speech-to-text
$CF_CMD create-service speech_to_text standard speech-to-text-service
# text-to-speech
$CF_CMD create-service text_to_speech standard text-to-speech-service

# Push app
HOST=$1
if ! $CF_CMD app $CF_APP; then
  $CF_CMD push $CF_APP -n $HOST
else
  OLD_CF_APP=${CF_APP}-OLD-$(date +"%s")
  rollback() {
    set +e
    if $CF_CMD app $OLD_CF_APP; then
      $CF_CMD logs $CF_APP --recent
      $CF_CMD delete $CF_APP -f
      $CF_CMD rename $OLD_CF_APP $CF_APP
    fi
    exit 1
  }
  set -e
  trap rollback ERR
  $CF_CMD rename $CF_APP $OLD_CF_APP
  $CF_CMD push $CF_APP -n $HOST
  $CF_CMD delete $OLD_CF_APP -f
fi
# Export app name and URL for use in later Pipeline jobs
export CF_APP_NAME="$CF_APP"
export APP_URL=http://$($CF_CMD app $CF_APP_NAME | grep urls: | awk '{print $2}')
# View logs
#$CF_CMD logs "${CF_APP}" --recent
