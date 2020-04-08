#!/bin/bash

# Generated bash script to invoke the health and ready HTTP endpoints
# of the deployed web application.

source bin/activate


echo ""
echo "=== Invoking westeurope"
python http-client.py get_health_alive http://51.138.42.147:80
sleep 1
python http-client.py get_health_ready http://51.138.42.147:80
sleep 2

echo ""
echo "=== Invoking centralindia"
python http-client.py get_health_alive http://13.71.55.252:80
sleep 1
python http-client.py get_health_ready http://13.71.55.252:80
sleep 2

echo ""
echo "=== Invoking japaneast"
python http-client.py get_health_alive http://20.44.168.96:80
sleep 1
python http-client.py get_health_ready http://20.44.168.96:80
sleep 2

echo ""
echo "=== Invoking westus"
python http-client.py get_health_alive http://13.83.71.106:80
sleep 1
python http-client.py get_health_ready http://13.83.71.106:80
sleep 2

echo ""
echo "=== Invoking eastus"
python http-client.py get_health_alive http://52.149.174.186:80
sleep 1
python http-client.py get_health_ready http://52.149.174.186:80
sleep 2


echo "done"