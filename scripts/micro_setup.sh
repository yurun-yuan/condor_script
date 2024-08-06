wget https://github.com/zyedidia/micro/releases/download/v2.0.13/micro-2.0.13-linux64.tar.gz
tar -xzf micro-2.0.13-linux64.tar.gz

mkdir -p ~/bin
mv micro-2.0.13/micro ~/bin/
export PATH=$PATH:~/bin
rm micro-2.0.13-linux64.tar.gz
rm -rf micro-2.0.13