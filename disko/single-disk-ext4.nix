{ config, lib, ... }:

let
  disks = config.local.storage.disks;
in
{
  options.local.storage.disks = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = ''
      Ordered disk device paths provided by the host. Disko layouts decide how
      to consume each index.
    '';
  };

  config = {
    assertions = [
      {
        assertion = builtins.length disks >= 1;
        message = "single-disk-ext4 requires at least one disk in local.storage.disks.";
      }
    ];

    disko.devices.disk.main = {
      type = "disk";
      # This layout consumes the first host-provided disk as the system disk.
      device = builtins.elemAt disks 0;
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
