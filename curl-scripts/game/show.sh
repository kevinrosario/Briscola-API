#!/bin/bash

curl "https://briscola-api.herokuapp.com/games" \
  --include \
  --request GET \
  --header "Content-Type: application/json" \
  --output "./curl-scripts/response/show.json" \
  --data '{
    "game": {
      "user_id": "'"${ID}"'"
    }
  }'

echo
