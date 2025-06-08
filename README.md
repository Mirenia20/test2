# Raccoon

DEPENDECY
-----
./install_dependency.sh
Build
-----
    meson setup build
    ninja -C build -j$(nproc)
    sudo ninja -C build install
    ./build/src/racoon

