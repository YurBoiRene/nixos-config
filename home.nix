{pkgs, ...}: {
  home.packages = with pkgs; [
    helix
  ];

  programs.home-manager.enable = true;

  home.homeDirectory = "/home/user";
  home.username = "user";
  home.stateVersion = "23.05";
}
