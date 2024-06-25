{ inputs, ... }: 
let
  microvm = inputs.microvm.nixosModules;
in
{
  imports = [ microvm.host ];
  microvm.vms = {
    uvm = {
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      config = {
        microvm.interfaces = [{
          type = "user";
          id = "vm-a1";
          mac = "02:00:00:00:00:01";
        }];
        microvm.shares = [{
          source = "/nix/store";
          mountPoint = "/nix/.ro-store";
          tag = "ro-store";
          proto = "virtiofs";
        }];
      };
    };
  };
}
