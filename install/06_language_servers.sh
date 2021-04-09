#!/bin/sh

set -e

# dockerfile
npm install -g dockerfile-language-server-nodejs

# ccls
cd "$HOME" &&
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls &&
    cd "$HOME"/ccls &&
    cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/local/Cellar/llvm/11.0.1/lib/cmake &&
    cmake --build Release --target install
