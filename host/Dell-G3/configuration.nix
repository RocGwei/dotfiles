{
  # config,
  # lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    # kernelPackages = pkgs.linuxKernel.kernels.linux_zen;
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        extraEntries = ''
          menuentry "Windows" {
              search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
              chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "Dell-G3";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Shanghai";

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      fira-code-nerdfont
      hanazono
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "FiraCode Nerd Font"
          "Noto Sans Mono CJK SC"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif CJK SC"
        ];
      };
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      type = "fcitx5";
      #waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        rime-data
        fcitx5-gtk
        fcitx5-rime
      ];
    };
  };

  programs = {
    hyprland.enable = true;
    waybar.enable = true;
    git = {
      enable = true;
      #userName = "Roc";
      #userEmail = "roc.gui@foxmail.com";
      #lfs.enable = true;
    };
    firefox.enable = true;
    vim.enable = true;
    clash-verge = {
      enable = true;
      package = pkgs.clash-verge-rev;
      # autostart = true;
      tunMode = true;
    };
    proxychains = {
      enable = true;
      package = pkgs.proxychains-ng;
      proxies = {
        local = {
          type = "socks5";
          host = "127.0.0.1";
          port = 7890;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
    curl
    wget
    fastfetch
    wl-clipboard
    tofi
    mako
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables = {
    EDITOR = "vim";
  };

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };
  };

  system.stateVersion = "24.05";
}
