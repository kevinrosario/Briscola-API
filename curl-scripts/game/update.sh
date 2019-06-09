#!/bin/bash

curl "http://localhost:4741/games/1" \
  --include \
  --request PUT \
  --header "Content-Type: application/json" \
  --data "@update.json"

echo
