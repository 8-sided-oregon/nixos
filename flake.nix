{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    awesome-neovim-plugins.url = "github:m15a/flake-awesome-neovim-plugins";
    awesome-neovim-plugins.inputs.nixpkgs.follows = "nixpkgs";
    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, awesome-neovim-plugins, microvm }@inputs: 
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
      specialArgs = { inherit hostnameCfg hostname inputs; microvm = microvm.nixosModules; };
      modules = [
        ./configuration.nix
        (hostnameCfg ./machines "")
        #./microvms.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ava = import ./home;
            extraSpecialArgs = inputs // { inherit hostnameCfg; };
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
