# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, lib, inputs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  # Generation label
  system.nixos.label = "Hypr-NixOS";

  # Bootloader
  time.hardwareClockInLocalTime = true;
  ### GRUB ###
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.milk-theme.enable = true;
  ### SYSTEMD ###
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.efi.efiSysMountPoint = "/boot";
  networking.hostName = "NixOS";
  networking.wireless.enable = true;

  home-manager.backupFileExtension = "bak";
  programs.nix-ld.enable = true;
  # bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  #services.blueman.withApplet = false;

  # veikk
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

  services.xserver = {
    enable = true;
    #displayManager.lightdm.enable = true;
    #windowManager.bspwm.enable = true;
  };

  # kde plasma 6
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm.enable = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    veikk-linux-driver
  ];

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  
  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 5900 5000 5800 1488 11434 42153 5173 56195 ];

  # pipewire
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;

  services.pipewire.extraConfig.pipewire."98-crackling-fix" = {
    "context.properties" = {
      "default.clock.quantum"     = 1024;
      "default.clock.min-quantum" = 1024;
      "default.clock.max-quantum" = 8192;
    };
  };

  services.pipewire.wireplumber.extraConfig."99-crackling-fix" = {
    "api.alsa.period-size" = 1024;
    "api.alsa.headroom"    = 8192;
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  
  programs.obs-studio = {
    enable = true;
  };
  
  users.groups.uinput = {};

  # virtual box
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  boot.kernelModules = [ "kvm-intel" "ch341" "usbserial" "uinput" ];

  # docs
  documentation.doc.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  services.ntp.enable = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Env variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  # docker
  virtualisation.docker = {
    enable = true;
  };

  #java
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  # Enable all firmware
  hardware.enableAllFirmware = true;

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      jetbrains-mono
    ];
  };
  
  # Define a user account
  users.users.harinezumi = {
    isNormalUser = true;
    description = "HarinezumiHaven";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "tty" "dialout" "libvirtd" "kvm" "video" "docker" "uinput" ];
  };

  # ZSH  
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "python3.12-ecdsa-0.19.1"
    ];
  };
  
  # Swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024;
  }];

  # gamemode
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk17}";
  };
  
  hardware.nvidia-container-toolkit.enable = true;
    virtualisation.docker.daemon.settings = {
    runtimes = {
      nvidia = {
        path = "nvidia-container-runtime";
        args = [];
      };
    };
  };
  virtualisation.docker.daemon.settings = {
    features.cdi = true;
  };
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # vibe
    clock-rs
    cmatrix
    fastfetch
    cava
    cmus
    thunar

    
    # rice
    feh
    dunst
    scrot
    pamixer
    slop
    xclip
    maim
    jq
    libnotify
    playerctl
    cliphist
    catppuccin-cursors.mochaDark
    catppuccin-cursors.mochaMauve
    

    # screenshot
    
    # programs
    icu
    appimage-run
    blockbench
    musescore
    sunvox
    the-powder-toy
    audacity
    ffmpeg
    ydotool
    unityhub
    libreoffice-fresh
    obsidian
    mpv-unwrapped
    w3m
    blender
    libresprite
    arduino-ide
    xclicker
    pear-desktop
    cowsay
    git
    vim
    neovim
    firefox
    tor
    ayugram-desktop
    vlc
    gdu
    kalker
    feh
    (discord.override {
      withVencord = true;
    })
    zip
    unzip
    foliate
    gparted
    prismlauncher
    vscodium
    jetbrains.idea
    ninja
    renpy
    krita
    
    # STEAM
    steam
    steam-unwrapped
    steam-run
    steamcmd

    openal
    udev
    libglvnd
    #openjdk21
    stdenv
    android-studio
    mesa
    #bottles
    
    # system
    pavucontrol
    home-manager
    busybox
    brightnessctl
    pipewire
    xdg-desktop-portal
    gnome-themes-extra
    ntfs3g
    file

    docker

    # cloudflare
    cloudflared

    # bluetooth
    blueman
    
    # wayland devs
    wayland
    wlroots

    # Python
    python312

    # c#
    dotnet-sdk_8 
   
    # Nim
    nim
    nimble

    # C
    gcc

    # Rust
    #rustc
    cargo
    #rustup
    
    # Node js
    nodejs_22

    # Java
    jdk17
    gradle
    gnumake

    # tauri on linux
    pkg-config
    openssl
    #libsoup
  ];

  # STEAM
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Auto-delete generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Flakes support
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Services
  services.tailscale.enable = true;

  system.stateVersion = "25.05";
}
