#!/bin/sh

ROUTER_URL="http://192.168.2.1"
PASSWORD="DEIN_SPEEDPORT_PASSWORT"
PORT=8124

apk add --no-cache curl jq flask

cat << EOF > /app/server.py
from flask import Flask, jsonify
import requests

ROUTER_URL = "$ROUTER_URL"
PASSWORD = "$PASSWORD"

session = requests.Session()

def fetch_data():
    try:
        session.post(f"{ROUTER_URL}/data/Login.json", data={"password": PASSWORD, "showpw": "0"})
        res = session.get(f"{ROUTER_URL}/data/DeviceList.json")
        return res.json()
    except Exception as e:
        return {"error": str(e)}

app = Flask(__name__)

@app.route("/")
def root():
    return jsonify(fetch_data())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=$PORT)
EOF

python3 /app/server.py
