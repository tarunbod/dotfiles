let
  monkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO3bNW+kEZUXvi2wT/VmJYoVro3UQPQsqid4C5n1aPhd";
  TMBP = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID5MXQhlVBZ+YDFl3WHO+QaN6j06AojAlyWygYpXfmeb";
  allKeys = [ monkey TMBP ];
in
{
  "secrets.age".publicKeys = allKeys;
}
