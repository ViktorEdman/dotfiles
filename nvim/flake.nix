{
  description = "Portable Neovim environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          neovim
          git
          ripgrep
          fd

          tree-sitter
          gcc
          gnumake

          nodejs

          lua-language-server
          gopls
          pyright

          stylua
          black
          gotools
        ];

        shellHook = ''
          echo "Neovim portable environment ready."
          echo "Run: ./bin/nvim"
        '';
      };
    };
}
