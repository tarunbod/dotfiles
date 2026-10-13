{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # Backport the macOS duplicate iconv alias fix; keep recode's tests enabled.
      recode = prev.recode.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (final.fetchurl {
            url = "https://github.com/rrthomas/recode/compare/daa2d7c73eb67235540690baa3a33141f1c60e4b...308a33e3a26b4bd779d4d5c1fa565b57c8939516.diff";
            hash = "sha256-9ga+Aik9YH2lXu+aYSwWNOZQnc5KmNzC38w0oUI/HmE=";
          })
        ];
      });
    })
  ];

  system.primaryUser = "tarunbod";

  homebrew.enable = true;
  homebrew.brews = [
    {
      name = "anomalyco/tap/opencode-v2";
      trusted = true;
    }
  ];

  homebrew.casks = [
    "bitwarden"
    "raycast"
    "rectangle"
    "ghostty"
    "obsidian"
  ];

  system.defaults.controlcenter.BatteryShowPercentage = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = 0.1;

  security.pam.services.sudo_local.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;
}
