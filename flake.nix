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
              ripgrep

              # LSPs
              ansible-language-server
              basedpyright
              bash-language-server
              clang-tools
              docker-language-server
              gopls
              lua-language-server
              nixd
              nodePackages.vscode-json-languageserver
              terraform-ls

              # Diagnostics/Formatters
              ansible-lint
              black # python
              gotools
              hclfmt # hcl/packer/terraform
              isort # python
              nixfmt-rfc-style
              prettierd # generic
              puppet-lint
              stylua
              trivy # terraform
              # yamllint # disabled due to it triggering in helm templates
            ];
            yaml = with pkgs; [
              helm-ls
              yaml-language-server
            ];
          };

          # Plugins loaded at startup
          startupPlugins = {
            gitPlugins = with pkgs.vimPlugins; [
              gitsigns-nvim
            ];
            general = with pkgs.vimPlugins; [
              alpha-nvim
              blink-cmp
              blink-ripgrep-nvim
              conform-nvim
              indent-blankline-nvim
              kanagawa-nvim
              lze
              mini-ai
              mini-comment
              mini-statusline
              mini-surround
              none-ls-nvim
              nvim-autopairs
              nvim-lspconfig
              nvim-treesitter-context
              nvim-treesitter-textobjects
              nvim-treesitter.withAllGrammars
              smart-splits-nvim
              tiny-inline-diagnostic-nvim
              todo-comments-nvim
              vim-matchup
              vim-sleuth
            ];
            neoTree = with pkgs.vimPlugins; [
              neo-tree-nvim
              nui-nvim
              nvim-web-devicons
              nvim-window-picker
              plenary-nvim
            ];
            snacks = with pkgs.vimPlugins; [
              snacks-nvim
            ];
            yaml = with pkgs.vimPlugins; [
              vim-helm
            ];
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          optionalPlugins = {
            gitPlugins = with pkgs.vimPlugins; [
              gitlinker-nvim
            ];
            general = with pkgs.vimPlugins; [
              grug-far-nvim
              switch-vim
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
              snacks = true;
              neoTree = true;
              yaml = true;
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
