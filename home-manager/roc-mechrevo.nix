{
  pkgs,
  ...
}:

{
  # home-manager for Archlinux on Mechrevo
  home = {
    username = "roc";
    homeDirectory = "/home/roc";
    packages = with pkgs; [
      nixfmt-rfc-style
    ];
    file = {
      # zsh
      ".zshrc".source = ./archlinux/zsh/.zshrc;

      # git
      ".gitconfig".source = ./archlinux/git/.gitconfig;
      ".gitmessage".source = ./archlinux/git/.gitmessage;

      # fontconfig
      ".config/fontconfig/fonts.conf".source = ./archlinux/fontconfig/fonts.conf;

      # rime
      ".local/share/fcitx5/rime/default.custom.yaml".source = ./archlinux/rime/default.custom.yaml;

      # vim
      ".vim/vimrc".source = ./archlinux/vim/vimrc;

      # nix
      ".config/nix/nix.conf".source = ./archlinux/nix/nix.conf;
    };
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
