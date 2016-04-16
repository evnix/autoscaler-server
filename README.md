# autoscaler-server

````
cd ~
mkdir -p test
cd test 
apt-get install git

#install ruby
apt-add-repository ppa:brightbox/ruby-ng
apt-get update
sudo apt-get install ruby2.3

gem install net-ssh
gem install net-scp
gem install sinatra
git clone https://github.com/evnix/autoscaler-server.git
cd autoscaler-server
chmod -R 0777 data

#fix config
vi server.config????

#clean DB
echo "" > data/db.yaml 

ruby supervisor.rb

````


Dependencies:


````
gem install net-ssh
gem install net-scp
gem install sinatra

gem install usagewatch

````
Fog


deployer running without update
wait: time.now
latest: 0000-00-00
deployed: 0000-00-00

if wait <= time.now
if deployed < latest
    deploy!

deployer running after update
wait: x
latest: 10
deployed: 0000-00-00

if time.now >= wait
if deployed < latest
    deploy!
