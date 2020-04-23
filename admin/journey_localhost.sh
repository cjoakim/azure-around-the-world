#!/bin/bash

# Script to execute/POST an around-the-world journey, pause, and then
# GET the resulting journey document from CosmosDB.
# Chris Joakim, Microsoft, 2020/04/23

source bin/activate

epoch_time=`date +%s`
pk="j"$epoch_time
url='http://127.0.0.1:3000'
journey_spec='relay-local-3.json'

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

