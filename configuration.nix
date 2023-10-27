{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vpn.nix
      ./gnome.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # TODO maybe use grub?
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # === NETWORKING ===
  networking.hostName = "crab";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  # === LOCALE, etc === 
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.spice-vdagentd.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # === USERS ===
  users = {
    mutableUsers = false;
    users = {
      rene = {
        isNormalUser = true;
        description = "rene";
        extraGroups = [ "networkmanager" "wheel" "dialout" ];
        hashedPasswordFile = "/nix/persist/keystore/passwords/rene"; # See utils/mkpasswd.sh
        shell = pkgs.fish;
      };
      root.hashedPasswordFile = "/nix/persist/keystore/passwords/root";
    };
  };

  programs.fish.enable = true;
  environment.pathsToLink = ["/share/fish"];

  # === SYSTEM PACKAGES ===
  environment.systemPackages = with pkgs; [
    vim
    spice-vdagent
    git
    home-manager
  ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
