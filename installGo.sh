#Install GOLANG
echo "Installing Go, this will take sometime (hours)"

cd ~
curl http://dave.cheney.net/paste/go-linux-arm-bootstrap-c788a8e.tbz | tar xj

git clone https://go.googlesource.com/go

cd ~/go
git checkout go1.7

ulimit -s 1024
ulimit -s 

cd ~/go/src
env GO_TEST_TIMEOUT_SCALE=10 GOROOT_BOOTSTRAP=~/go-linux-arm-bootstrap ./all.bash

echo "Install - Done"

echo "Don't forget to set $GOPATH=~/go and add to your $PATH"
echo "remove go-linux-arm-bootstrap, using: rm -rf go-linux-arm-bootstrap"
