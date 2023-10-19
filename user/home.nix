{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    rnix-lsp
    direnv

    fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fd
    fzf
    fishPlugins.grc
    grc
    
    meld
    evolution
    decoder

    ffmpeg
    zip
    rsync
    gimp


    roboto
  ];

  programs.home-manager.enable = true;

  home.homeDirectory = "/home/user";
  home.username = "user";
  home.stateVersion = "23.05";

  programs.direnv.enable = true;
  programs.kitty.enable = true;
  programs.git = {
    enable = true;
    userName = "YurBoiRene";
    userEmail = "renedes@protonmail.com";
  };
  
  programs.fish = {
    enable = true;
    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      gs = "git status";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    enableUpdateCheck = false;
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "rnix-lsp";
    };
  };

  programs.firefox = {
    enable = true;
    
    profiles.default = {
      name = "Default";
      id = 0;
      isDefault = true;
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
      };
      bookmarks = [
        {
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
        {
          name = "nix package search";
          keyword = "nix";
          url = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=%s";
        }
        {
          name = "kernel.org";
          url = "https://www.kernel.org";
        }
      ];
    };
  };
  
}
