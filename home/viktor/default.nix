{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ../../modules/home/neovim.nix
  ];

  home = {
    username = username;
    homeDirectory = "home/${username}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

}
