# Note: setup $HOME with available quota before running this script
mkdir -p ~/bin
wget https://github.com/git-lfs/git-lfs/releases/download/v3.5.1/git-lfs-linux-amd64-v3.5.1.tar.gz
tar -xvzf git-lfs-linux-amd64-v3.5.1.tar.gz -C ~/bin
rm git-lfs-linux-amd64-v3.5.1.tar.gz
mv ~/bin/git-lfs-3.5.1/git-lfs ~/bin
export PATH=$PATH:~/bin
git lfs install
