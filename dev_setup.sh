with-proxy curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# install zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# install miniconda
curl 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh' > Miniconda3.sh

# install pt conda env
source ~/.zshrc
with-proxy conda create -n pt
conda activate pt

# install vim
cd ~/local/
git clone https://github.com/vim/vim.git

# install ncurse-devel to support vim depending on platform (centos here)
sudo yum install ncurses-devel

# install vim in personal home dir
cd vim
./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \
    --enable-python3interp=yes \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-cscope \
    --prefix=$HOME

sudo make install


# install necessary vim components (ctags, ag, etc.)
sudo yum-install ctags-etags
sudo yum-install the_silver_searcher


# install pytorch

git clone --recursive https://github.com/wanchaol/pytorch.git && cd pytorch

ln -s ~/local/pytorch ~/pytorch

git config --global credential.helper 'cache --timeout=31536000'

git remote -v
git remote add upstream https://github.com/pytorch/pytorch.git
git remote -v
git submodule update --init

# c2 and ccache
sudo yum install asciidoc
with-proxy conda install cmake automake autoconf ninja

# pytorch install
export CMAKE_PREFIX_PATH="/home/wanchaol/local/conda"
with-proxy conda install numpy pyyaml mkl mkl-include setuptools cmake cffi typing

with-proxy conda install -c pytorch magma-cuda92
with-proxy pip install git-feature


# install ccache
mkdir -p ~/ccache
pushd /tmp
rm -rf ccache
git clone https://github.com/colesbury/ccache.git -b ccbin
pushd ccache
./autogen.sh
./configure
make install prefix=~/ccache
popd && popd

mkdir -p ~/ccache/lib
ln -s ~/ccache/bin/ccache ~/ccache/lib/cc
ln -s ~/ccache/bin/ccache ~/ccache/lib/c++
ln -s ~/ccache/bin/ccache ~/ccache/lib/gcc
ln -s ~/ccache/bin/ccache ~/ccache/lib/g++
~/ccache/bin/ccache -M 25Gi

# devgpu install
mkdir -p ~/ccache/cuda
ln -s ~/ccache/bin/ccache ~/ccache/cuda/nvcc
export PATH=~/ccache/lib:/usr/local/cuda/bin:$PATH
export CUDA_NVCC_EXECUTABLE=~/ccache/cuda/nvcc
~/ccache/cuda/nvcc --version
