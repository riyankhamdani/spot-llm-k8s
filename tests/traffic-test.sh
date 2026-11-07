#!/bin/bash
echo "Menjalankan load traffic terus menerus... (Ctrl+C untuk berhenti)"
SUCCESS=0
FAILED=0

while true; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 2 -X POST http://localhost:8000/v1/completions \
    -H "Content-Type: application/json" \
    -d '{"prompt": "Loadtest", "max_tokens": 10}')
  
  TIMESTAMP=$(date +'%H:%M:%S')
  if [ "$STATUS" -eq 200 ]; then
    SUCCESS=$((SUCCESS + 1))
    echo "[$TIMESTAMP] Status: $STATUS OK | Success: $SUCCESS | Failed: $FAILED"
  else
    FAILED=$((FAILED + 1))
    echo "[$TIMESTAMP] Status: $STATUS FAILED! | Success: $SUCCESS | Failed: $FAILED"
  fi
  sleep 0.3
done
