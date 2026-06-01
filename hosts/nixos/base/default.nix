{
  config,
  pkgs,
  lib,
  hostname,
  username,
  ...
}:

{
  imports = [
    ../../modules/nixos/common.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos.base.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = "24.05";
}
