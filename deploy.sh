#!/bin/bash

# set project dir
cd /home/vo/projects/ognev.dev/ || exit

echo "Making archive..."
cd ..
tar -czf ognevdev.tar.gz ognev.dev

echo "Uploading project archive..."
gcloud compute --project "ognevdev" scp ognevdev.tar.gz front:/home/vo/

echo "Connecting to remove host..."
gcloud beta compute --project "ognevdev" ssh --zone "us-central1-a" "front" << EOF
cd /home/vo
echo "Extracting from archive..."
tar -xzf ognevdev.tar.gz
sudo rm -rf /var/www/html
sudo mv ognev.dev /var/www/html

sudo rm -f ognevdev.tar.gz
EOF

rm -f ognevdev.tar.gz

echo "ognev.dev deployed!"
