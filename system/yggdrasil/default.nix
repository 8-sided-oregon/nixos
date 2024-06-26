{ config, hostname, ... }:
{
  services.yggdrasil.enable = true;
  services.yggdrasil.configFile = config.age.secrets."yggdrasil-${hostname}".path;
  services.yggdrasil.openMulticastPort = true;
}
