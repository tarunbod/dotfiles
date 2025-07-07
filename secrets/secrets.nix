let
  monkey_system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHlF2NovIJm1sblPZqOVBILOMZie/r+a6ol3qgPHip4R";
  monkey_user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO3bNW+kEZUXvi2wT/VmJYoVro3UQPQsqid4C5n1aPhd tarunbod@nixos";
  TMBP_system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUfwC+s6n/4WdaY0imcch0iLb00xvbogGY7ITL4vs78";
  TMBP_user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID5MXQhlVBZ+YDFl3WHO+QaN6j06AojAlyWygYpXfmeb tarunbod@TMBP.local";
  allKeys = [ monkey_system monkey_user TMBP_system TMBP_user ];
in
{
  "github_token.age".publicKeys = allKeys;
}
