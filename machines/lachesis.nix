{ config, lib, pkgs, modulesPath, ... }:
let
  openedDisk = "/dev/disk/by-uuid/4b5fa290-b005-45ea-8c23-0c51d86c3ec1";
in
{
  imports = [
    ../users/ava.nix
    ../system/crypt
    ../system/gaming
    ../system/cups
    ../system/git
    ../system/nfs
    ../system/power
    ../system/wm
    ../system/yggdrasil
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    resumeDevice = openedDisk;
    # IMPORTANT: MUST BE CHANGED TO MATCH SWAP FILE IN ORDER FOR HIBERNATION TO WORK
    # you can get the resume offset by running `filefrag -v <swapfile>` and then taking the
    # first value in the physicial_offset column (there are two values for every row) in the
    # first row.
    kernelParams = [ "resume_offset=53272576" ];
  };

  fileSystems."/" =
    { device = openedDisk;
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-533dce17-b96e-4808-a0f0-8870c68d4b7f".device = "/dev/disk/by-uuid/533dce17-b96e-4808-a0f0-8870c68d4b7f";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8E69-3366";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ 
    {
      device = "/swapfile";
      size = 36 * 1024;
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s20f0u1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.logind.lidSwitch = "hibernate";
  services.logind.lidSwitchExternalPower = "hibernate";
  services.logind.lidSwitchDocked = "hibernate";

  environment.systemPackages = with pkgs; [
    # i like manuals
    man-pages
    clang-manpages
    linux-manual
    man-pages-posix
    stdman
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8000 ];
  };
}
