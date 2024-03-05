
FROM ubuntu:20.04



RUN dpkg --add-architecture armhf && apt-get update
# https://stackoverflow.com/questions/49377744/how-to-run-docker-image-in-ubuntu-with-vnc
RUN apt-get install -y x11vnc xvfb \
    apt-utils \
    libc6:armhf \
    unrar wget
# https://ptitseb.github.io/box86/COMPILE.html



# INSTALL VNC
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd
# ENTRYPOINT ["x11vnc -forever -usepw -create & && /bin/b'ash"]
# CMD /usr/local/sbin/bnetd
# x11vnc -forever -usepw -create &
# sudo x11vnc -forever -usepw -create &


# INSTALL D2GS
RUN apt-get install unrar
RUN wget https://harpywar.com/files/items/d2gs/D2GS-113d-build01.rar
# https://stackoverflow.com/questions/22730756/unrar-all-file-in-directory-without-prompting#:~:text=You%20need%20to%20specify%20%2Do%2B%20to%20enable%20automatic%20overwriting%3A
# RUN unrar x D2GS-113d-build01.rar -o+




# INSTALL box86
RUN apt-get install gnupg -y
# https://ioflood.com/blog/install-gpg-command-linux/

RUN  wget https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list -O /etc/apt/sources.list.d/box86.list
RUN wget -qO- https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg
RUN apt update && apt install box86:armhf -y
# https://forum.armbian.com/topic/22926-armbian-build-error-unable-to-locate-package-box86/
# box86:armhf \
# RUN box86 --version

# INSTALL WINE
# RUN apt-get install xz-utils 

# RUN apt-get update && apt-get install -y \
#   make \
#   wget \
#   flex \
#   bison \
#   xz-utils \
#   gcc-multilib \
#   g++-multilib


# https://superuser.com/questions/801159/cannot-decompress-tar-xz-file-getting-xz-cannot-exec-no-such-file-or-direct

# RUN cd /home
# RUN wget http://dl.winehq.org/wine/source/2.0/wine-2.0.1.tar.xz
# RUN tar xf wine-2.0.1.tar.xz.1
# RUN rm wine-2.0.1.tar.xz.1
# RUN wget https://gist.githubusercontent.com/HarpyWar/cd3676fa4916ea163c50/raw/50fbbff9a310d98496f458124fac14bda2e16cf0/sock.c
# RUN mv sock.c wine-2.0.1/server
# RUN mv wine-2.0.1 wine-source
# RUN mkdir wine-dirs
# RUN mv wine-source wine-dirs
# RUN cd wine-dirs
# RUN mkdir wine-build
# RUN cd wine-build
# WORKDIR "/home/wine-dirs/wine-build"
# RUN box86 ../wine-source/configure --without-x  --without-freetype



# # https://ptitseb.github.io/box86/X86WINE.html#:~:text=Installing%20Wine%20for%20Box86%20on%20Raspberry%20Pi%20OS%20from%20WineHQ%20.deb%20files
# RUN wbranch="devel"
# # example: devel, staging, or stable (wine-staging 4.5+ requires libfaudio0:i386 - see below)
# RUN wversion="7.1" 
# #example: 7.1
# RUN wid="ubuntu" 
# #example: debian, ubuntu
# RUN wdist="focal" 
# #example (for debian): bullseye, buster, jessie, wheezy, etc
# #example (for ubuntu): bionic is for 18, focal is for 20.04, etc
# RUN wtag="-1" 
# #example: -1 (some wine .deb files have -1 tag on the end and some don't)


RUN apt-get update && apt-get install -y sudo build-essential curl git libfreetype6-dev libzmq3-dev pkg-config python-dev python-numpy software-properties-common swig zip
# RUN useradd -rm -d /home/john -s /bin/bash -g root -G sudo -u 1001 john -p "$(openssl passwd -1 ubuntu)"
# USER john
# WORKDIR /home/john
COPY /*.sh /
CMD ["/bin/bash"]