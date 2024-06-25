{ config, lib, ... }:
{
  options.hyfetch.prideflag = lib.mkOption {
    type = lib.types.str;
    default = "transgender";
  };

  config.programs.hyfetch.enable = true;
  config.programs.hyfetch.settings = {
    preset = "${config.hyfetch.prideflag}";
    mode = "rgb";
    color_align.mode = "horizontal";
  };
}
