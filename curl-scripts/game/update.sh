#!/bin/bash

curl "http://localhost:4741/games/1" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --data "@update.json"

echo
