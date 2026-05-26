{ config, pkgs, ... }:

{
  home.username = "viktor";
  home.homeDirectory = "/home/viktor";
  home.stateVersion = "24.11";
  xdg.configFile."nvim".source = ./nvim;
  home.packages = with pkgs; [neovim];
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
      power-theme
        sensible
    ];
    extraConfig = ''
      set-option -g renumber-windows on
      set-option -g set-clipboard on
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      set -g @catppuccin_flavour 'frappe'
      set -g @tmux_power_theme 'forest'
    '';
  };
}
