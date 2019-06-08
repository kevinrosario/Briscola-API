#!/bin/bash

curl "http://localhost:4741/games/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --data '{
    "game": {
      "player_one_hand": "'"${HAND}"'",
      "current_cards": "'"${CURRENT}"'"
    }
  }'

echo
