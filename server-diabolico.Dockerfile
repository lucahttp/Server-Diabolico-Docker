# Especifica la imagen base (Ubuntu 20.04)
FROM ubuntu:20.04

# ENV TZ=Europe/Minsk
ENV TZ=America/Argentina/Buenos_Aires
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# docker run --name my-container -it ubuntu:20.04 


# Instala las dependencias necesarias
# RUN apt-get update && apt-get install -y build-essential cmake git
RUN apt-get update && apt-get install -y build-essential cmake git clang libc++-dev zlib1g-dev liblua5.1-0-dev libmysql++-dev
# sudo apt-get -y install build-essential clang libc++-dev git cmake zlib1g-dev liblua5.1-0-dev libmysql++-dev

WORKDIR /pvpgn-server
# Clona el repositorio PvPGN-Server
RUN git clone https://github.com/pvpgn/pvpgn-server .

# Compila PvPGN-Server

RUN cmake .
RUN make install > logfile.txt 2>&1
# Configura PvPGN-Server (coloca tu archivo de configuración en /etc/pvpgn)

# Ejecuta PvPGN-Server
# CMD /pvpgn/bnetd -c /etc/pvpgn/pvpgn.conf

# cat /usr/local/var/pvpgn/bnetd.log
# ls /usr/local/var/pvpgn/userlogs
# CMD /usr/local/sbin/bnetd
CMD ["/bin/bash"]

