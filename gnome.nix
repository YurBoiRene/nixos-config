
{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.tracker-miners.enable = false;
  services.gnome.tracker.enable = false;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  
  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.caffeine
    gnomeExtensions.impatience
    gnomeExtensions.noannoyance-fork
    gnomeExtensions.spotify-tray
    gnomeExtensions.clipboard-indicator

    gnome.gnome-tweaks
  ];
}
