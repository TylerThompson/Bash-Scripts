#!/usr/bin/env bash
############################
#   Tyler James Thompson   #
#       MongoDB Setup      #
############################
# This will install MongoDB on Ubuntu 14.04
# Import the public key used by the package management system
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
# Create a list file for MongoDB
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
# Reload local package database
sudo apt-get update
# Install the MongoDB Packages
sudo apt-get install -y mongodb-org
# Create database
sudo mkdir -p /data
sudo mkdir -p /data/db
# Below is to install specific version (Note: We don't need a specific version right now (11/24/2016))
#sudo apt-get install -y mongodb-org=3.0.13 mongodb-org-server=3.0.13 mongodb-org-shell=3.0.13 mongodb-org-mongos=3.0.13 mongodb-org-tools=3.0.13
# Create the service script in systemd which
# tells the system how to start up, shutdown and handle the service job
#sudo touch /etc/systemd/system/mongodb.service
sudo echo "[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target

[Service]
User=mongodb
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/mongodb.service
# Start the newly created mongo service
sudo systemctl start mongodb
# Check the status of mongo
sudo systemctl status mongodb
# Enable automatic start-up on boot
sudo systemctl enable mongodb
################################
# If you want to allow incoming connections access to your db server (Not recommended)
# sudo ufw allow 27017 # Uncomment if you want this
# Allow access from another server (on your network)
# sudo ufw allow form you_server_ip_here/port here (32-27017)
# verify firewall settings
# sudo ufw status
# Double check that the mongo service is healthy
sudo mongod # This will do health checks of the system &
# Start the MongoDB Service