
FROM ubuntu:20.04

# https://stackoverflow.com/questions/49377744/how-to-run-docker-image-in-ubuntu-with-vnc
RUN apt-get update
RUN apt-get install -y x11vnc xvfb 
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd
COPY entrypoint.sh /entrypoint.sh
# ENTRYPOINT ["x11vnc -forever -usepw -create & && /bin/bash"]
# CMD /usr/local/sbin/bnetd

# x11vnc -forever -usepw -create &
CMD ["/bin/bash"]