{ config, pkgs, ... }:

{
  home.username = "viktor";
  home.homeDirectory = "/home/viktor";
  home.stateVersion = "24.11";
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-b";
    package = pkgs.tmux;
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      sensible
      better-mouse-mode
    ];
    extraConfig = ''
      set-option -g renumber-windows on
      set-option -sa terminal-features ',tmux-256color:RGB'
      set-option -g set-clibpoard on

      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      set -g @catppuccin_flavour 'frappe'
    '';
  };
}
