import os
import yaml

# Use:
# source ../env.sh ; python gen-values-yaml.py

mongodb_values = dict()
mongodb_values['mongodbUsername'] = os.environ['MONGODB_USER']
mongodb_values['mongodbPassword'] = os.environ['MONGODB_PASS']
mongodb_values['mongodbDatabase'] = os.environ['MONGODB_DBNAME']

with open('../unit-04/mongodb-values.yaml', 'w') as file:
    documents = yaml.dump(mongodb_values, file)
