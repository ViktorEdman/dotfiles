{
  nixos-wsl,
  ...
}:
{
  imports = [
    nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "viktor";
}
