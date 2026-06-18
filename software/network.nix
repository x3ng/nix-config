{ config, pkgs, ... }:

{
  # 基础网络配置
  # 注意：NetworkManager + systemd-resolved 配置在各代理模块中（mihomo.nix 等）
  # 因为 resolved 是为代理 DNS 缓冲服务的，不属于通用网络基础配置

  networking.hostName = "ocean";

  networking.networkmanager = {
    enable = true;
  };

}
