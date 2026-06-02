1. Install nix package manager for your OS
2. Three modes of operation:
    1.  sudo nixos-rebuild --switch .#wsl - for the nixos WSL image
    2.  sudo nixos-rebuild --switch .#vm - for a generic (bare metal) nixos system 
    3.  nix run home-manager/master -- init --switch flake . - for a home-manager based installation
