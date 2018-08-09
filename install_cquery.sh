# install cquery, subject to change, consult the latest doc before use this
if ! ls ~/bin/cquery
then
    mkdir -p ~/bin/
    pushd /tmp
    rm -rf cquery
    git clone https://github.com/cquery-project/cquery.git --recursive
    mkdir -p cquery/build/
    pushd cquery/build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
    make
    cmake --build . --target install
    cp ./cquery ~/bin/
    popd
    popd
fi
