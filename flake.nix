{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager }: 
  let
    config = hostname:
    let
      hostnameCfg = parent: suffix: 
        let 
          path = nixpkgs.lib.path.append parent "${hostname}${suffix}.nix";
          exists = nixpkgs.lib.filesystem.pathIsRegularFile path;
        in
        if exists then path else {};
    in
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { 
        inherit hostnameCfg hostname; 
      };
      modules = [
        ./configuration.nix 
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ava = import ./home-manager/home.nix;
            extraSpecialArgs.hostnameCfg = hostnameCfg;
          };
        }
      ];
    };
  in
  {
    nixosConfigurations.atropos = config "atropos";
    nixosConfigurations.lachesis = config "lachesis";
  };
}
