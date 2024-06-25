let
  lachesis = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+Ge8vYuR+lc7PtLSv57LmvLEi4CXdrU24i2RxXMYZw";
in
{
  "yggdrasil-lachesis.age".publicKeys = [ lachesis ];
}
