{ programs, lib, ...}:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = lib.mkDefault true;
    extraConfig = lib.fileContents ./init.vim;
  };
}