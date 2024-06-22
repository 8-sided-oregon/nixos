{ microvm, ... }: {
  imports = [ microvm.host ];
  microvms.vms = {
    uvm = {
      pkgs = import nixpkgs { system = "x86_64-linux"; }
      config = {
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
