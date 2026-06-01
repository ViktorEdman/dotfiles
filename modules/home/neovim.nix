{ pkgs }:

let
  configDir = pkgs.runCommand "nvim-config" { } ''
    mkdir -p $out/nvim
    cp -r ${./config}/* $out/nvim
  '';

  lspTools = with pkgs; [
    nil
    basedpyright
    ruff
    gopls
    bash-language-server
  ];

  baseTools = with pkgs; [
    git
    ripgrep
    fd
  ];
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ pkgs.neovim ] ++ baseTools ++ lspTools;
  text = ''
    export XDG_CONFIG_HOME="${configDir}"
    exec ${pkgs.neovim}/bin/nvim "$@"
  '';
}
