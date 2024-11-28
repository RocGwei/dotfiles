{
  pkgs,
  ...
}:

{
  # home-manager for NixOS on Dell-G3 with Hyperland
  home = {
    username = "roc";
    homeDirectory = "/home/roc";
    packages = with pkgs; [
      nixfmt-rfc-style
    ];
    stateVersion = "24.05";
  };

  #wayland.windowManager.hyperland = {
  #  enable = true;
  #  package = pkgs.hyprland;
  #  xwayland.enable = true;
  #  #systemd.enable = true;
  #};

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      #autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -l";
        lla = "ls -lA";
      };
    };
  };
}
