{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = "viktor";
  home.homeDirectory = "/home/viktor";
  home.stateVersion = "24.11";

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."nvim/lua".source = ./nvim/lua;
  home.packages = with pkgs; [
    nil
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      ignoreAllDups = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };
    shellAliases = {
      ls = "lsd";
      update = "source ~/dotfiles/hm_switch.sh";
    };
    antidote = {
      enable = true;
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [

      lazy-nvim
      cmp-nvim-lsp
      cmp-nixpkgs-maintainers

    ];
  };
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
