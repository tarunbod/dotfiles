let
  allKeys = builtins.fromJSON (builtins.readFile ./keys.json);
in
{
  "secrets.age" = {
    publicKeys = builtins.attrValues allKeys;
    armor = true;
  };
}
