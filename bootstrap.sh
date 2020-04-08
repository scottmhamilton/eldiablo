#!/usr/bin/env bash

sudo apt-get install gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" |
sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list


sudo apt-get update

echo "Installing base packages..."
sudo apt-get install zlib1g-dev
sudo apt-get install git <<-EOF
yes
EOF
sudo apt-get install g++ <<-EOF
yes
EOF
sudo apt-get install default-jre <<-EOF
yes
EOF
sudo apt-get install zip
sudo apt-get install unzip
sudo apt-get install libxml2-dev <<-EOF
yes
EOF
sudo apt-get install libxslt1-dev <<-EOF
yes
EOF
sudo apt-get install python-dev <<-EOF
yes
EOF
sudo apt-get install python-pip <<-EOF
yes
EOF

echo "Cloning Phoenix pipeline files..."
sudo git clone https://github.com/scottmhamlton/phoenix_pipeline.git
sudo git clone https://github.com/scottmhamilton/scraper.git
sudo git clone https://github.com/scottmhamilton/stanford_pipeline.git

echo "Installing Python dependencies..."
sudo pip install -r scraper/requirements.txt
sudo pip install -r phoenix_pipeline/requirements.txt
sudo pip install -r stanford_pipeline/requirements.txt

echo "Installing PETRARCH..."
sudo pip install git+https://github.com/scottmhamilton/petrarch2.git
cd

echo "Downloading CoreNLP..."
sudo wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip
sudo unzip stanford-corenlp-full-2018-10-05.zip
mv stanford-corenlp-full-2018-10-05 /home/vagrant/stanford-corenlp
cd /home/vagrant/stanford-corenlp
echo "Downloading shift-reduce parser..."
sudo wget http://nlp.stanford.edu/software/stanford-srparser-2014-07-01-models.jar

echo "Downloading NLTK data..."
sudo mkdir -p nltk_data/tokenizers
cd nltk_data/tokenizers
sudo wget http://www.nltk.org/nltk_data/packages/tokenizers/punkt.zip
sudo unzip punkt.zip
cd
sudo mv nltk_data /usr/lib/nltk_data

echo "Installing MongoDB..."
sudo apt-get install -y mongodb-org

echo "Setting up crontab..."
sudo apt update
sudo apt install cron
sudo crontab /vagrant/crontab.txt
