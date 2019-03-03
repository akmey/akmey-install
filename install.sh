#!/usr/bin/env bash
lastrelease=$(curl --silent https://api.github.com/repos/akmey/akmey-client/releases/latest|grep tag_name|cut -c 16-|sed 's/.\{2\}$//')
OSTYPE=$(uname)
OSARCH=$(uname -m)
if [ "$EUID" -ne 0 ]; then
isroot=false
else
isroot=true
fi

if [[ $OSARCH  ==  "x86_64" ]]; then
	OSARCH="amd64"
fi
echo "https://github.com/akmey/akmey-client/releases/download/$lastrelease/akmey-client-$OSTYPE-$OSARCH"
wget "https://github.com/akmey/akmey-client/releases/download/$lastrelease/akmey-client-$OSTYPE-$OSARCH"
mv "akmey-client-$OSTYPE-$OSARCH" akmey
chmod +x akmey
if [[ $isroot == "false" ]]; then
read -r -p "Do you want to move Akmey to /usr/bin? (needs sudo if ran as user) [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
sudo mv akmey /usr/bin
echo "Akmey is now installed at /usr/bin/akmey 🚀"
else
exit
fi
else
read -r -p "Do you want to move Akmey to /usr/bin? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
mv akmey /usr/bin
echo "Akmey is now installed at /usr/bin/akmey 🚀"
else 
	exit
fi
fi
