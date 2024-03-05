### User-defined Wine version variables ################
# - Replace the variables below with your system's info.
# - Note that we need the i386 version for Box86 even though we're installing it on our ARM processor.
# - Wine download links from WineHQ: https://dl.winehq.org/wine-builds/

wbranch="stable"
# example: devel, staging, or stable (wine-staging 4.5+ requires libfaudio0:i386 - see below)
wversion="7.1" 
#example: 7.1
wid="ubuntu" 
#example: debian, ubuntu
wdist="focal" 
#example (for debian): bullseye, buster, jessie, wheezy, etc
#example (for ubuntu): bionic is for 18, focal is for 20.04, etc
wtag="-1" 
#example: -1 (some wine .deb files have -1 tag on the end and some don't)



mkdir ~/Downloads

# Download, extract wine, and install wine
cd ~/Downloads
# wget https://dl.winehq.org/wine-builds/${wid}/dists/${wdist}/main/binary-i386/wine-${wbranch}-i386_${wversion}~${wdist}${wtag}_i386.deb # download
# wget https://dl.winehq.org/wine-builds/${wid}/dists/${wdist}/main/binary-i386/wine-${wbranch}_${wversion}~${wdist}${wtag}_i386.deb # (required for wine_i386 if no wine64 / CONFLICTS WITH wine64 support files)
# dpkg-deb -x wine-${wbranch}-i386_${wversion}~${wdist}${wtag}_i386.deb wine-installer # extract
# dpkg-deb -x wine-${wbranch}_${wversion}~${wdist}${wtag}_i386.deb wine-installer

wget https://dl.winehq.org/wine-builds/${wid}/dists/${wdist}/main/binary-amd64/wine-${wbranch}-amd64_${wversion}~${wdist}${wtag}_amd64.deb # download
wget https://dl.winehq.org/wine-builds/${wid}/dists/${wdist}/main/binary-amd64/wine-${wbranch}_${wversion}~${wdist}${wtag}_amd64.deb # (required for wine_amd64 if no wine64 / CONFLICTS WITH wine64 support files)
dpkg-deb -x wine-${wbranch}-amd64_${wversion}~${wdist}${wtag}_amd64.deb wine-installer # extract
dpkg-deb -x wine-${wbranch}_${wversion}~${wdist}${wtag}_amd64.deb wine-installer

mv wine-installer/opt/wine* ~/wine # install
rm wine*.deb # clean up
rm -rf wine-installer # clean up


# Install shortcuts (make 32bit launcher & symlinks. Credits: grayduck, Botspot)
echo -e '#!/bin/bash\nsetarch linux32 -L '"$HOME/wine/bin/wine "'"$@"' | tee -a /usr/local/bin/wine >/dev/null # Create a script to launch wine programs as 32bit only
#sudo ln -s ~/wine/bin/wine /usr/local/bin/wine # You could aslo just make a symlink, but box86 only works for 32bit apps at the moment
ln -s ~/wine/bin/wineboot /usr/local/bin/wineboot
ln -s ~/wine/bin/winecfg /usr/local/bin/winecfg
ln -s ~/wine/bin/wineserver /usr/local/bin/wineserver
chmod +x /usr/local/bin/wine /usr/local/bin/wineboot /usr/local/bin/winecfg /usr/local/bin/wineserver



# These packages are needed for running wine on a 64-bit RPiOS via multiarch
karch=$(uname -m)
if [ "$karch" = "aarch64" ] || [ "$karch" = "aarch64-linux-gnu" ] || [ "$karch" = "arm64" ] || [ "$karch" = "aarch64_be" ]; then
    dpkg --add-architecture armhf && apt-get update # enable multi-arch
    apt-get install -y libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf \
        libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libldap-2.4-2:armhf libopenal1:armhf libpcap0.8:armhf \
        libpulse0:armhf libsane1:armhf libudev1:armhf libusb-1.0-0:armhf libvkd3d1:armhf libx11-6:armhf libxext6:armhf \
        libasound2-plugins:armhf ocl-icd-libopencl1:armhf libncurses6:armhf libncurses5:armhf libcap2-bin:armhf libcups2:armhf \
        libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libglu1:armhf libgnutls30:armhf \
        libgssapi-krb5-2:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf \
        libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf \
        libxrender1:armhf libxxf86vm1 libc6:armhf libcap2-bin:armhf # to run wine-i386 through box86:armhf on aarch64
        # This list found by downloading...
        #	wget https://dl.winehq.org/wine-builds/debian/dists/bullseye/main/binary-i386/wine-devel-i386_7.1~bullseye-1_i386.deb
        #	wget https://dl.winehq.org/wine-builds/debian/dists/bullseye/main/binary-i386/winehq-devel_7.1~bullseye-1_i386.deb
        #	wget https://dl.winehq.org/wine-builds/debian/dists/bullseye/main/binary-i386/wine-devel_7.1~bullseye-1_i386.deb
        # then `dpkg-deb -I package.deb`. Read output, add `:armhf` to packages in dep list, then try installing them on Pi aarch64.
fi




# These packages are needed for running wine-staging on RPiOS (Credits: chills340)
# apt install libstb0 -y
# cd ~/Downloads
# wget -r -l1 -np -nd -A "libfaudio0_*~bpo10+1_i386.deb" http://ftp.us.debian.org/debian/pool/main/f/faudio/ # Download libfaudio i386 no matter its version number
# dpkg-deb -xv libfaudio0_*~bpo10+1_i386.deb libfaudio
# sudo cp -TRv libfaudio/usr/ /usr/
# rm libfaudio0_*~bpo10+1_i386.deb # clean up
# rm -rf libfaudio # clean up


apt install libstb0 -y
cd ~/Downloads
wget -r -l1 -np -nd -A "libfaudio0_*~bpo10+1_i386.deb" http://ftp.us.debian.org/debian/pool/main/f/faudio/ # Download libfaudio i386 no matter its version number
dpkg-deb -xv libfaudio0_*~bpo10+1_i386.deb libfaudio
cp -TRv libfaudio/usr/ /usr/
rm libfaudio0_*~bpo10+1_i386.deb # clean up
rm -rf libfaudio # clean up





apt-get install cabextract -y                                                                   # winetricks needs this installed
mv /usr/local/bin/winetricks /usr/local/bin/winetricks-old                                      # Backup old winetricks
cd ~/Downloads && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks # Download
chmod +x winetricks && mv winetricks /usr/local/bin/       
# Boot wine (make fresh wineprefix in ~/.wine )
wine wineboot