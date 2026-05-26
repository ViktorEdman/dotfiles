{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-b";
    package = pkgs.tmux;
    plugins = with pkgs.tmuxPlugins; [
      continuum
      yank
      dractula
    ];
  };
}
