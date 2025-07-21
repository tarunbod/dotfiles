{ pkgs, ...}:

{
  environment.systemPackages = [
    pkgs.gopls
    pkgs.nil
    pkgs.ruff
    pkgs.typescript-language-server

    pkgs.uv
    pkgs.rustup
  ];
}
