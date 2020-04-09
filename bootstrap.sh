#!/usr/bin/env bash
##updated to new version xenial and attemppted to switch mongo version
###delted mongodb installation. instead of doing this through the bootstrap which caused many errors,
###I ran vagrant up with a blank boostrap, ssh'd into the virtual machine,
###Installed mongodb 3.4 multiverse and will now run the remaining part of bootstrap by swapping the
###original back in minus everything related to mongodb 

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install --assume-yes --allow-unauthenticated mongodb-org


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
export LC_ALL=C
sudo pip install pip --upgrade pip
##up to here everything is ok
echo "Cloning Phoenix pipeline files..."
##check
sudo git clone https://github.com/scottmhamilton/phoenix_pipeline.git 
##check
sudo git clone https://github.com/scottmhamilton/scraper.git
##check
sudo git clone https://github.com/scottmhamilton/stanford_pipeline.git

echo "Installing Python dependencies..."
sudo pip install -r scraper/requirements.txt 
##check
sudo pip install -r phoenix_pipeline/requirements.txt
##check but on updating petrarch gits there was a yellow message about egg requirements
sudo pip install -r stanford_pipeline/requirements.txt
##check but ERROR: petrarch 0.1a0 has requirement six==1.6.1, but you'll have six 1.9.0 which is incompatible
##lets see what happens, mate


echo "Installing PETRARCH..."
sudo pip install git+https://github.com/openeventdata/petrarch2.git
##already satisfied
cd

echo "Downloading CoreNLP..."
##update from stanford-corenlp-full-2014-06-16.zip to standford-corenlp-full-2018-10-05.zip
sudo wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip
#check
sudo unzip stanford-corenlp-full-2018-10-05.zip
#check
mv stanford-corenlp-full-2018-10-05 /home/vagrant/stanford-corenlp
#check
cd /home/vagrant/stanford-corenlp
echo "NOT Downloading shift-reduce parser..."
#removed shift reduce parser because it is now part of corenlp

echo "Downloading NLTK data..."
sudo mkdir -p nltk_data/tokenizers
cd nltk_data/tokenizers
sudo wget http://www.nltk.org/nltk_data/packages/tokenizers/punkt.zip
sudo unzip punkt.zip
cd
cd stanford-corenlp
sudo mv nltk_data /usr/lib/nltk_data
###a bit of shimmying around with the root but that should do it



echo "Setting up crontab..."
sudo crontab /vagrant/crontab.txt
