{
  config,
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

    file = {
      ".local/share/fcitx5/rime/default.custom.yaml".text = ''
        patch:
          menu/page_size: 8
          schema_list:
            - schema: double_pinyin_flypy
            - schema: luna_pinyin
      '';
    };

    stateVersion = "24.11";
  };

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        rime-data
        fcitx5-gtk
        fcitx5-rime
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      monitor = ",1920x1080,auto,1";
      "$terminal" = "kitty";
      "$fileManager" = "$terminal -- ranger";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "waybar"
        # "mako"
        # "hyprlock"
        "fcitx5"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;

        border_size = 2;

        layout = "dwindle";
      };

      decoration = {
        rounding = 5;

        blur = {
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
        numlock_by_default = true;
        accel_profile = "flat";
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, tofi-run | xargs hyprctl dispatch exec --"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # mouse movements
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Roc";
      userEmail = "roc.gui@foxmail.com";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -l";
        lla = "ls -lA";
      };
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      initExtra = ''
        source $HOME/.p10k.zsh
        export PATH="$HOME/.local/bin:$PATH"
      '';
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    kitty = {
      enable = true;
      themeFile = "GruvboxMaterialDarkMedium";
    };
    tofi = {
      enable = true;
      settings = {
        background-color = "#000000";
        border-width = 0;
        font = "monospace";
        height = "100%";
        num-results = 5;
        outline-width = 0;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = 25;
        width = "100%";
      };
    };
    waybar = {
      enable = true;
      # settings = {};
      # style = {};
    };
    hyprlock = {
      enable = true;
    };
  };

  services = {
    mako = {
      enable = true;
    };
  };
}
