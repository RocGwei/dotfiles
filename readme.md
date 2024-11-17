# Dotfile

Dotfile with home-manager

## Usage (temporary)

1. Install nix

    ```bash
    sudo pacman -S nix
    ```

2. Config nix

    In `/etc/nix/nix.conf`, add

    ```conf
    experimental-features = nix-command flakes
    substituters = https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/
    ```

    or temporary configuration, run

    ```bash
    export NIX_CONFIG="experimental-features = nix-command flakes"
    ```

3. Clone this repo anywhere, and get into the repo

    ```bash
    git clone  https://github.com/RocGwei/dotfiles.git
    cd dotfiles
    ```

4. Setup home-manager

    If you don't have home-manager (check with `home-manager --version`) run

    ```bash
    nix run nixpkgs#home-manager -- switch --flake .#username@hostname
    ```

    and `home-manager` will manage itself

    If have, just run

    ```bash
    home-manager switch --flake .#username@hostname
    ```

## TODO

- [ ] configuration for multiple machine(current only Archlinux)
- [ ] finish bootstrap script for Archlinux
