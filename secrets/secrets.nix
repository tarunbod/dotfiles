let
  TMBP = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID5MXQhlVBZ+YDFl3WHO+QaN6j06AojAlyWygYpXfmeb tarunbod@TMBP.local";
  TMBP_system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUfwC+s6n/4WdaY0imcch0iLb00xvbogGY7ITL4vs78";
  allKeys = [ TMBP TMBP_system ];
in
{
  "github_token.age".publicKeys = allKeys;
}
