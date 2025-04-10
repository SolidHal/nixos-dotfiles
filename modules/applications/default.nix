# general applications
{ pkgs, inputs, ... }:

{
  imports =
  [
    ./zoom.nix
  ];


# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Set Firefox as the default browser
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };
  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basic tools
    dtrx
    file
    fzf
    git
    nautilus
    ripgrep
    wget

    # baisc dev env
    gcc14
    python3
    ruff # linter for python

    # use our neovim/nixvim config
    inputs.nvix.packages.${pkgs.system}.core


    # other apps
    bambu-studio
    borgbackup
    calibre
    chromium
    discord
    freecad-wayland
    gimp
    gparted
    handbrake
    imagemagick
    keepassxc
    kicad
    krita
    libreoffice-qt
    ncdu # tui for disk usage
    openscad
    qflipper
    signal-desktop
    spotify
    thunderbird
    vorta
    wireshark-qt
    yt-dlp


    # desktop shortcuts
    (pkgs.makeDesktopItem {
      name = "firefoxWork";
      desktopName = "Firefox Work";
      exec = "/run/current-system/sw/bin/firefox -P Work";
      keywords = ["firefox" "work"];
    })

  ];

  # configure syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    # run as user
    user = "eva";
    # lets use the usual syncthing config rather than confiuring syncthing
    # with nix
    dataDir = "/home/eva";  # default location for new folders
    configDir = "/home/eva/.config/syncthing";
    # Dont delete devices and folders that are created
    # by the web interface
    overrideDevices = false;
    overrideFolders = false;

  };


}
