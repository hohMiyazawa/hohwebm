sudo apt install gcc cmake make yasm perl
cd ~
git clone --depth 1 https://aomedia.googlesource.com/aom
mkdir aom_build
cd aom_build && cmake ../aom
make
sudo cp aomenc /usr/local/bin/aomenc
sudo cp aomdec /usr/local/bin/aomdec
