set -ex

mkdir build || true

pushd build

# Get the emsdk repo
if [ ! -d "emsdk" ]; then
    git clone https://github.com/emscripten-core/emsdk.git
fi

# Enter that directory
pushd emsdk

# Download and install the latest SDK tools.
./emsdk install latest

# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
./emsdk activate latest

# Activate PATH and other environment variables in the current terminal
source ./emsdk_env.sh

popd

emcmake cmake -DENABLE_PYTHON_INTERFACE=OFF -DNOM4RI=ON \
    -DENABLE_TESTING=OFF -DNOZLIB=ON -DONLY_SIMPLE=ON \
    -DEMSCIPTEN=ON \
    ..

emmake make

popd
