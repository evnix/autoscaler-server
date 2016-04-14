# autoscaler-server

Dependencies:
gem install net-ssh
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