{ ... }:

{
  # NVMe power management (APST)
  boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];
}