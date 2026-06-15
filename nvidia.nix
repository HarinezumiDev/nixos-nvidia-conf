{ config, lib, pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia-container-toolkit.enable = true;
  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
    libnvidia-container
  ];
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  services.xserver.screenSection = ''
    Option "metamodes" "1360x768 +0+0"
    Option "SLI" "Off"
    Option "MultiGPU" "Off"
    Option "BaseMosaic" "off"
  '';
}
