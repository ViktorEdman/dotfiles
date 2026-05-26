{ config, pkgs, ... }:

{
  home.username = "viktor";
  home.homeDirectory = "/home/viktor";
  home.stateVersion = "24.11";
  home.file.".config/tmux-powerline/config.sh".text = ''
    export TMUX_POWERLINE_LEFT_STATUS_SEGMENTS="session_info hostname"
    export TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS="lan_ip wan_ip date_time"
    export TMUX_POWERLINE=DATE_FORMAT="%F"
    export TMUX_POWERLINE=TIME_FORMAT="%H:%M"
  '';
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
      better-mouse-mode
      tmux-powerline
    ];
    extraConfig = ''
      set-option -g renumber-windows on
      set-option -sa terminal-features ',tmux-256color:RGB'
      set-option -g set-clipboard on
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      set -g @catppuccin_flavour 'frappe'
    '';
  };
}
