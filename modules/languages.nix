{ pkgs, ...}:

{
  environment.systemPackages = [
    pkgs.astro-language-server
    pkgs.gopls
    pkgs.nil
    pkgs.ruff
    pkgs.rustup
    pkgs.typescript-language-server
    pkgs.uv
  ];
}
