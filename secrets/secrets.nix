let
  monkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHlF2NovIJm1sblPZqOVBILOMZie/r+a6ol3qgPHip4R";
  TMBP = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUfwC+s6n/4WdaY0imcch0iLb00xvbogGY7ITL4vs78";
  allKeys = [ monkey TMBP ];
in
{
  "github_token.age".publicKeys = allKeys;
}
