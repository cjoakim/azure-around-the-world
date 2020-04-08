#!/bin/bash

# Script to execute/POST an around-the-world journey, pause, and then
# GET the resulting journey document from CosmosDB.
# Chris Joakim, Microsoft, 2020/04/03

source bin/activate

epoch_time=`date +%s`
pk="j"$epoch_time
url='http://52.149.174.186'
journey_spec='relay-planet-aks.json'

echo 'url: '$url
echo 'pk:  '$pk

python http-client.py get_health_alive $url
python http-client.py get_health_ready $url

# echo 'POSTing the journey to: '$url
python http-client.py post_journey_relay $url $journey_spec $pk

echo 'pausing 3 seconds...'
sleep 3

# echo 'GETting journey: '$pk
python http-client.py get_journey_by_pk $url $pk

