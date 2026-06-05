{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "viktor";
  home.homeDirectory = "/home/viktor";
  home.stateVersion = "25.11";

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."nvim/lua".source = ./nvim/lua;
  home.packages = with pkgs; [
    home-manager
    git

    # Formatters
    nixfmt # nix
    stylua # lua
    black # python

    # LSP servers
    nixd # nix
    basedpyright # python
    lua-language-server # lua
    gopls # go
    vscode-json-languageserver # json

    # Compilers & interpreters
    cargo # rust
    rustc # rust
    python3 # python
    nodejs # javascript
    gcc # c/c++
    gnumake
    cmake
    pkg-config
    uv # python

    # Syntax highlighting
    tree-sitter # neovim dependency

    # Terminal niceties
    zoxide # smart cd
    pure-prompt # zsh prompt
    fzf # fuzzy finding, for zsh and neovim
    ripgrep # fast grep
    fd # fast file search
    lsd # eyecandy ls
    fastfetch # for clout

  ];
  programs.zoxide = {
    enableZshIntegration = true;
    enable = true;
  };
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
    initContent = ''
      autoload -U promptinit
      promptinit
      prompt pure
      source <(fzf --zsh)
      eval "$(zoxide init zsh)"
    '';

  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withRuby = false;
    withPython3 = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [

      lazy-nvim
      cmp-nvim-lsp
      cmp-nixpkgs-maintainers
      nvim-treesitter

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
      better-mouse-mode
      {
        plugin = gruvbox;
        extraConfig = ''
          set -g @tmux-gruvbox-right-status-z "#h "
        '';
      }
      sensible
    ];
    extraConfig = ''
      set-option -g renumber-windows on
      set-option -g set-clipboard on
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

    '';
  };
}
