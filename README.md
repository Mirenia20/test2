# Raccoon


Build
-----
    meson setup build
    ninja -C build -j$(nproc)
    sudo ninja -C build install
    ./build/src/racoon

