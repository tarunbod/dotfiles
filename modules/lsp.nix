{ pkgs, ...}:

{
  environment.systemPackages = [
    pkgs.gopls
    pkgs.typescript-language-server
    pkgs.ruff
    pkgs.nil
  ];
}
