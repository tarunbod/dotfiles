{ pkgs, ...}:

{
  environment.systemPackages = [
    pkgs.astro-language-server
    pkgs.gopls
    pkgs.nil
    pkgs.ruff
    pkgs.typescript-language-server

    pkgs.uv
    pkgs.rustup
  ];
}
