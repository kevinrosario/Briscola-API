#!/bin/bash

curl "http://localhost:4741/games" \
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