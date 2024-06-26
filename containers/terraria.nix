{ config, pkgs, lib, ... }: {
  options.terraria.autoStart = lib.mkOption {
    type = lib.types.bool;
    description = "whether to autostart the container";
    default = false;
  };

  #TODO: Add a password file option
  options.terraria.port = lib.mkOption {
    type = lib.types.int;
    description = "port to open the terraria server on";
    default = 7777;
  };

  config = {
    containers.terraria = {
      autoStart = config.terraria.autoStart;
      privateNetwork = true;
      # the terraria server only listens on ipv4. ipv6 connections have to be proxied
      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.11";
      bindMounts = {
        "/rw" = { hostPath = "/var/lib/terraria"; isReadOnly = false; };
      };
      specialArgs = { inherit (config.terraria) port; };
      config = { port, config, pkgs, lib, ... }: {
        nixpkgs.config.allowUnfree = true;
        environment.systemPackages = [ pkgs.python3 ];
        services.terraria = {
          enable = true;
          port = port;
          openFirewall = true;
          noUPnP = true;
          dataDir = "/rw/data";
          worldPath = "/rw/data/.local/share/Terraria/Worlds/World.wld";
        };
        system.stateVersion = "24.05";
      };
    };

    users.users.terraria = {
      description = "Terraria server service user";
      group       = "terraria";
      uid         = config.ids.uids.terraria;
    };

    users.groups.terraria = {
      gid = config.ids.gids.terraria;
    };
  };
}
