{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    ../users/ava.nix
    ../system/crypt
    ../system/cups
    ../system/git
    ../system/power
    ../system/wm
    ../system/yggdrasil
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a9ca5d6f-933f-409b-83de-096315718831";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-7a0b3d29-d473-4bb3-a67c-39ce4555afd3".device = "/dev/disk/by-uuid/7a0b3d29-d473-4bb3-a67c-39ce4555afd3";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2856-21A0";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";
  services.logind.lidSwitchDocked = "suspend";
}
