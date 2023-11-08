{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    nil
    direnv

    gnumake

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

    vscode-fhs

    zip

    # ffmpeg
    # rsync
    # gimp


    # roboto
  ];

  imports = [
    editors/neovim/neovim.nix
  ];

  programs.home-manager.enable = true;

  home.homeDirectory = "/home/rene";
  home.username = "rene";
  home.stateVersion = "23.05";

  programs.direnv = {
    enable = true;
    # Fish integration automatically enabled
    nix-direnv.enable = true;
  };
  programs.kitty.enable = true;
  programs.kitty.font = {
    package = pkgs.jetbrains-mono;
    name = "JetBrains Mono";
    size = 15;
  };
  programs.git = {
    enable = true;
    userName = "rene";
    userEmail = "renedes@protonmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
    aliases = {
      clog = "log-specific --all";
      clogs = "log-specific";
      log-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'";
    };
    extraConfig = {
      pull.ff = "only";
      commit.verbose = "true";
    };
  };
  
  programs.fish = {
    enable = true;
    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
    shellAbbrs = {
      gs = "git status";
      infra = "/home/rene/Documents/Java/OSUCyberSecurityClub/repos/infra/";
      javad = "/home/rene/Documents/Java/";
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
