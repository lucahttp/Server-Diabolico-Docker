
FROM ubuntu:20.04

# https://stackoverflow.com/questions/49377744/how-to-run-docker-image-in-ubuntu-with-vnc
RUN apt-get update
RUN apt-get install -y x11vnc xvfb 
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd


# https://ptitseb.github.io/box86/COMPILE.html
RUN apt-get install apt-utils
RUN dpkg --add-architecture armhf && sudo apt-get update
RUN apt-get install libc6:armhf -y

RUN apt-get install box86:armhf

RUN box86 --version
RUN apt-get install unrar
RUN wget https://harpywar.com/files/items/d2gs/D2GS-113d-build01.rar
RUN unrar x D2GS-113d-build01.rar


# ENTRYPOINT ["x11vnc -forever -usepw -create & && /bin/b'ash"]
# CMD /usr/local/sbin/bnetd

# x11vnc -forever -usepw -create &
CMD ["/bin/bash"]