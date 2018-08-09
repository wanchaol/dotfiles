# install and export ccache
if ! ls ~/bin/ccache/bin/ccache
then
    mkdir -p ~/bin/ccache
    pushd /tmp
    rm -rf ccache
    git clone https://github.com/colesbury/ccache -b ccbin
    pushd ccache
    ./autogen.sh
    ./configure
    make install prefix=~/bin/ccache
    popd
    popd

    mkdir -p ~/bin/ccache/lib
    mkdir -p ~/bin/ccache/cuda
    ln -s ~/bin/ccache/bin/ccache ~/bin/ccache/lib/cc
    ln -s ~/bin/ccache/bin/ccache ~/bin/ccache/lib/c++
    ln -s ~/bin/ccache/bin/ccache ~/bin/ccache/lib/gcc
    ln -s ~/bin/ccache/bin/ccache ~/bin/ccache/lib/g++
    ln -s ~/bin/ccache/bin/ccache ~/bin/ccache/cuda/nvcc

    ~/bin/ccache/bin/ccache -M 25Gi
fi

echo "export PATH=~/bin/ccache/lib:$PATH" >> ~/.zshrc
echo "export CUDA_NVCC_EXECUTABLE=~/bin/ccache/cuda/nvcc" >> ~/.zshrc
