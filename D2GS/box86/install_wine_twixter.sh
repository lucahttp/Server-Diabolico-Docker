# Backup any old wine installations
mv ~/wine ~/wine-old
mv ~/.wine ~/.wine-old
mv /usr/local/bin/wine /usr/local/bin/wine-old
mv /usr/local/bin/wineboot /usr/local/bin/wineboot-old
mv /usr/local/bin/winecfg /usr/local/bin/winecfg-old
mv /usr/local/bin/wineserver /usr/local/bin/wineserver-old

# Download, extract wine, and install wine (last I checked, the Twister OS FAQ page had Wine 5.13-devel)
wget https://twisteros.com/wine.tgz -O ~/wine.tgz
tar -xzvf ~/wine.tgz
rm ~/wine.tgz # clean up

# Install shortcuts (make launcher & symlinks. Credits: grayduck, Botspot)
echo -e '#!/bin/bash\nsetarch linux32 -L '"$HOME/wine/bin/wine "'"$@"' | tee -a /usr/local/bin/wine >/dev/null # Create a script to launch wine programs as 32bit only
#ln -s ~/wine/bin/wine /usr/local/bin/wine # You could also just make a symlink, but box86 only works for 32bit apps at the moment
ln -s ~/wine/bin/wineboot /usr/local/bin/wineboot
ln -s ~/wine/bin/winecfg /usr/local/bin/winecfg
ln -s ~/wine/bin/wineserver /usr/local/bin/wineserver
chmod +x /usr/local/bin/wine /usr/local/bin/wineboot /usr/local/bin/winecfg /usr/local/bin/wineserver

# Boot wine (make fresh wineprefix in ~/.wine )
wine wineboot