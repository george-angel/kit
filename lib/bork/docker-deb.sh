ok apt curl
ok apt gnupg2
ok apt ca-certificates
ok apt apt-transport-https
ok apt software-properties-common
ok apt docker-ce
if did_error; then
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
  apt-key fingerprint 0EBFCD88
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
  apt-get update
  ok apt docker-ce
fi
