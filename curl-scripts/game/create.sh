#!/bin/bash

curl "http://localhost:4741/games" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --output "./curl-scripts/response/create.txt" \
  --data '{
    "game": {
      "user_id": "'"${ID}"'"
    }
  }'

echo
