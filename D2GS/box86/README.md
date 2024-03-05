 wget https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list -O /etc/apt/sources.list.d/box86.list
wget -qO- https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg
 apt update && sudo apt install box86 -y









# when doesnt work
docker build --pull --no-cache --rm -f "xserver_and_box86_and_wine.Dockerfile" -t xserver_and_box86_and_wine:latest "."
docker run --rm -ti -i -t -d --privileged -p 5900:5900 --name xserver_and_box86_and_wine xserver_and_box86_and_wine:latest


# for faster builds
docker build --pull --rm -f "xserver_and_box86_and_wine.Dockerfile" -t xserver_and_box86_and_wine:latest "."
docker run --rm -ti -i -t -d -p 5900:5900 --name xserver_and_box86_and_wine xserver_and_box86_and_wine:latest


# for faster builds with 
# wine wineboot
# setarch: failed to set personality to linux32: Operation not permitted
# https://github.com/moby/moby/issues/32839
docker build --pull --rm -f "xserver_and_box86_and_wine.Dockerfile" -t xserver_and_box86_and_wine:latest "."
docker run --rm -ti -i -t -d --privileged -p 5900:5900 --name xserver_and_box86_and_wine xserver_and_box86_and_wine:latest

