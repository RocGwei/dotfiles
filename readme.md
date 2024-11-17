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

    or temporary config

    ```conf
    export NIX_CONFIG="experimental-features = nix-command flakes"
    ```

3. Clone this repo inside `~/.config/home-manager`

    ```bash
    git clone ... ~/.config/home-manager
    ```

4. Setup home-manager

    If you don't have home-manager (check with `home-manager --version`) run

    ```bash
    nix run nixpkgs#home-manager -- switch
    ```

    and `home-manager` will manage itself

    If have, just run

    ```bash
    home-manager -- switch
    ```

## TODO

- [ ] configuration for multiple machine(current only Archlinux)
- [ ] finish bootstrap script
