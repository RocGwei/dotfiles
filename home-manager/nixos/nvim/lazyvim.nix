{
  lib,
  pkgs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # c/cpp
      clang-tools
      # vscode-extensions.vadimcn.vscode-lldb
      # cmake
      neocmakelsp
      cmake-lint
      # lua
      lua-language-server
      stylua
      # nix
      nil
      # markdown
      markdownlint-cli2
      marksman
      # tailwindcss
      tailwindcss-language-server
      # json
      python312Packages.python-lsp-jsonrpc
      # other tools
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig =
      let
        plugins = with pkgs.vimPlugins; [
          telescope-fzf-native-nvim
          markdown-preview-nvim
        ];
        mkEntryFromDrv =
          drv:
          if lib.isDerivation drv then
            {
              name = "${lib.getName drv}";
              path = drv;
            }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        require("lazy").setup({
          defaults = {
            lazy = true,
          },
          dev = {
            -- reuse files from pkgs.vimPlugins.*
            path = "${lazyPath}",
            patterns = { "" },
            -- fallback to download
            fallback = true,
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- The following configs are needed for fixing lazyvim on nix
            -- force enable telescope-fzf-native.nvim
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
            -- disable mason.nvim, use programs.neovim.extraPackages
            { "folke/tokyonight.nvim", enabled = false, },
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            { "williamboman/mason.nvim", enabled = false },
            -- import/override with your plugins
            { import = "lazyvim.plugins.extras.lang.clangd" },
            -- { import = "lazyvim.plugins.extras.dap.core" },
            { import = "lazyvim.plugins.extras.lang.cmake" },
            { import = "lazyvim.plugins.extras.lang.git" },
            { import = "lazyvim.plugins.extras.lang.json" },
            { import = "lazyvim.plugins.extras.lang.tailwind" },
            { import = "lazyvim.plugins.extras.lang.markdown" },
            { import = "lazyvim.plugins.extras.lang.nix" },
            { import = "lazyvim.plugins.extras.coding.mini-surround" },
            { import = "lazyvim.plugins.extras.coding.neogen" },
            { import = "lazyvim.plugins.extras.editor.refactoring" },
            { import = "lazyvim.plugins.extras.ui.treesitter-context" },
            { import = "plugins" },
            -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
            { "nvim-treesitter/nvim-treesitter",
                opts = function(_, opts)
                opts.ensure_installed = {}
              end,
            },
          },
        })
      '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
}
