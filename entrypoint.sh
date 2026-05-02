#!/bin/bash

# 1. Start WireMock in the background
echo "Starting WireMock..."
java -jar /opt/wiremock.jar --root-dir ./test/wiremock --port 9090 &

# 2. Wait a moment for WireMock to start
sleep 2

# 3. Start Flask in the foreground
echo "Starting Flask App..."
export FLASK_APP=app/api.py
exec flask run --host=0.0.0.0 --port 5000