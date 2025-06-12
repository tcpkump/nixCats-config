{
  description = "tcpkump neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs =
    {
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = {
        # allowUnfree = true;
      };
      dependencyOverlays = [
        (utils.standardPluginOverlay inputs)
      ];

      categoryDefinitions =
        {
          pkgs,
          ...
        }:
        {
          # Dependencies available at runtime (LSPs, formatters, etc.)
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              lazygit

              # LSPs
              ansible-language-server
              basedpyright
              bash-language-server
              clang-tools
              docker-language-server
              gopls
              helm-ls
              lua-language-server
              nixd
              terraform-ls
              yaml-language-server

              # Diagnostics
              stylua
              gotools
              hclfmt
              nixfmt-rfc-style
              prettierd
              puppet-lint
              trivy
            ];
          };

          # Plugins loaded at startup
          startupPlugins = {
            gitPlugins = with pkgs.vimPlugins; [
              gitsigns-nvim
            ];
            general = with pkgs.vimPlugins; [
              kanagawa-nvim
              lze
              blink-cmp
              conform-nvim
              smart-splits-nvim
              nvim-autopairs
              lualine-nvim
              vim-sleuth
              mini-ai
              mini-comment
              mini-surround
              none-ls-nvim
              vim-helm
              indent-blankline-nvim
              nvim-treesitter.withAllGrammars
              alpha-nvim
              tiny-inline-diagnostic-nvim
            ];
            neoTree = with pkgs.vimPlugins; [
              neo-tree-nvim
              nui-nvim
              nvim-web-devicons
              nvim-window-picker
              plenary-nvim
            ];
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          optionalPlugins = {
            gitPlugins = with pkgs.vimPlugins; [
              lazygit-nvim
              gitlinker-nvim
            ];
            general = with pkgs.vimPlugins; [
              grug-far-nvim
            ];
            telescope = with pkgs.vimPlugins; [
              telescope-fzf-native-nvim
              telescope-ui-select-nvim
              telescope-nvim
              telescope-live-grep-args-nvim
            ];
          };

          # Shared libraries added to LD_LIBRARY_PATH
          # sharedLibraries = {
          #   general = with pkgs; [ ];
          # };

        };

      packageDefinitions = {
        nvim =
          { ... }:
          {
            settings = {
              wrapRc = true;
              aliases = [ "vim" ];
            };
            categories = {
              general = true;
              gitPlugins = true;
              customPlugins = true;
              telescope = true;
              neoTree = true;
            };
          };
      };
      defaultPackageName = "nvim";
    in

    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = utils.mkAllWithDefault defaultPackage;

        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = '''';
          };
        };

      }
    )
    // (
      let
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
        homeModule = utils.mkHomeModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
      in
      {
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      }
    );

}
