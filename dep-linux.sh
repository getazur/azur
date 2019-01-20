sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update
sudo apt-get install aptitude -y
sudo aptitude install -y build-essential g++-8 gcc-8 git libboost-all-dev python-pip
sudo pip install cmake
export CC=gcc-8
export CXX=g++-8
