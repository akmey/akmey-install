#!/usr/bin/env bash
lastrelease="v0.1.5-alpha"
OSTYPE=$(uname)
OSARCH=$(uname -m)
echo "OSTYPE:"
echo $OSTYPE
echo "OSARCH:"
echo $OSARCH
if [[ $OSARCH  ==  "x86_64" ]]; then
	OSARCH="amd64"
fi
echo "https://github.com/akmey/akmey-client/releases/download/$lastrelease/akmey-client-$OSTYPE-$OSARCH"
wget https://github.com/akmey/akmey-client/releases/download/$lastrelease/akmey-client-$OSTYPE-$OSARCH
mv akmey-client-$OSTYPE-$OSARCH akmey
chmod +x akmey
read -r -p "Do you want to move Akmey to /usr/bin? (needs sudo/doas) [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
if [[ $OSTYPE  ==  "Linux" ]]; then
	sudo mv akmey /usr/bin
else
	if [[ $OSTYPE ==  "OpenBSD" ]]; then
	doas mv akmey /usr/bin
fi
fi

else
  exit
fi
