 wget https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list -O /etc/apt/sources.list.d/box86.list
wget -qO- https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg
 apt update && sudo apt install box86 -y









# when doesnt work
docker build --pull --no-cache --rm -f "xserver_and_box86_and_wine.Dockerfile" -t xserver_and_box86_and_wine:latest "."
docker run --rm -ti -i -t -d --privileged -p 5900:5900 --name xserver_and_box86_and_wine xserver_and_box86_and_wine:latest
docker run --rm -ti  -itd --privileged  -p 5900:5900 --name xserver_and_box86_and_wine xserver_and_box86_and_wine:latest


# for faster builds
docker build --pull --rm -f "xserver_and_box86_and_wine.Dockerfile" -t xserver_and_box86_and_wine:latest "."
docker run --rm -ti -i -t -d -p 5900:5900 --name xserver_and_box86_and_wine xserver_and_box86_and_wine:latest


# for faster builds with 
# wine wineboot
# setarch: failed to set personality to linux32: Operation not permitted
# https://github.com/moby/moby/issues/32839
docker build --pull --rm -f "xserver_and_box86_and_wine.Dockerfile" -t xserver_and_box86_and_wine:latest "."
docker run --rm -ti -i -t -d --privileged -p 5900:5900 --name xserver_and_box86_and_wine xserver_and_box86_and_wine:latest





https://dl.winehq.org/wine-builds/ubuntu/dists/focal/main/binary-i386/?C=M;O=A

docker wine box86 

/root/wine/bin/wine: 1: Syntax error: "(" unexpected
https://github.com/ptitSeb/box86/issues/588
https://stackoverflow.com/questions/72622846/getting-error-syntax-error-unexpected-when-building-a-c-program-in-docker



docker
    System has not been booted with systemd as init system (PID 1). Can't operate. Failed to connect to bus: Host is down
https://stackoverflow.com/questions/59466250/docker-system-has-not-been-booted-with-systemd-as-init-system



setarch: failed to set personality to linux32: Operation not permitted
wine wineboot setarch: failed to set personality to linux32: Operation not permitted
failed to set personality to linux32: Operation not permitted
    https://github.com/moby/moby/issues/20634
https://ptitseb.github.io/box86/X86WINE.html

vscode remote ssh windows https://superuser.com/questions/1296024/windows-ssh-permissions-for-private-key-are-too-open
https://code.visualstudio.com/docs/remote/troubleshooting#_reusing-a-key-generated-in-puttygen