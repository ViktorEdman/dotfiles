{ pkgs, ... }:

{
  home.packages = with pkgs; [
    curl
    git
    ripgrep
    fd
    tree
    jq
  ];
}
