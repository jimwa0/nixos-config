{ config, pkgs, unstable, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # automatic updating
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.hostName = "pasokon";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant
  services.avahi = {
    enable = true;
    publish.enable = true;
  };

  # network proxy
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # locale
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # X11
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # disable debounce (for drag clicking)
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';

  # fcitx5-mozc
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc-ut
      # fcitx5-rime
      # rime-ice
      fcitx5-gtk
    ];
  };

  # enable CUPS to print documents
  # services.printing.enable = true;

  # pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # packages
  environment.systemPackages = with pkgs; [
    # CUSTOM
    (callPackage ../pkgs/ninb.nix {})

    # SYSTEM
    nh
    gdu
    qdirstat
    # nix-index
    xwayland-satellite
    brightnessctl
    # alacritty
    # ghostty 
    kitty
    fastfetch
    hyfetch
    # waybar
    # waybar-mpris
    # swww
    # wofi
    # fuzzel
    # nwg-bar
    jq
    # dunst
    libnotify
    wl-clipboard 
    starship
# maybe important
    # xdg-desktop-portal-wlr
    # kdePackages.xdg-desktop-portal-kde
#
    # kdePackages.dolphin
    # kdePackages.okular
    # kdePackages.gwenview
    # kdePackages.ark
    # kdePackages.discover
    kdePackages.kdeconnect-kde
    kdePackages.partitionmanager
    posy-cursors
    gpu-screen-recorder
    # nushell
    # dwm
    # dmenu
    # st
    # jellyfin-rpc
    jellyfin-tui

    # UTIL
    # zsh-autosuggestions
    # zsh-syntax-highlighting
    vim
    neovim
    # emacs
    # vscode
    git
    tmux
    btop
    zoxide
    eza
    fd
    ripgrep
    fzf
    curl
    ffmpeg
    nautilus
    tree
    wget
    p7zip
    # stow
    # valgrind
    # gdb
    # yt-dlp
    # virtualbox
    # remmina
    # tigervnc
    pastel

    # DEVELOPMENT
    gcc
    python3
    nodejs
    jdk17
    # clang
    # cmake
    # gnumake
    # ninja
    # rustup
    # lua
    # luajit
    # jre8
    # jre17_minimal
    # arduino-ide

    # PRODUCTIVITY
    obsidian
    discord
    # element-desktop
    zellij
    qbittorrent
    vlc
    # libreoffice
    anki
    # sioyek
    # spotify
    # deadbeef
    # cmus
    # rmpc
    # mpd
    # cloudflared
    ticktick
    # quartus-prime-lite
    # ltspice
    # kicad

    # MULTIMEDIA
    obs-studio
    kdePackages.kdenlive
    gimp
    lmms
    audacity

    # GAMES
    osu-lazer-bin
    steamtinkerlaunch
    # taisei
    prismlauncher
    waywall
    glfw3-minecraft
    # glfw

    # FUN
    cava
    tty-clock
    cmatrix
    cbonsai
    pipes
    figlet

    # other
    sddm-astronaut
    kdePackages.qtmultimedia
    easyeffects 
    # libxkbcommon
    # libx11
    # libxinerama
    # libxkbcommon
    # libxt
  ];

  # nix-ld
  # programs.nix-ld.enable =  true;
  # programs.nix-ld.libraries = with pkgs; [];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # DE/WM/WC
  # programs.niri.enable = true;
  services.desktopManager.plasma6.enable = true;
  # programs.hyprland = {
    # enable = true;
    # programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
  # }
  # services.xserver.windowManager.dwm.enable = true;

  # WM services
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # kdePackages.xdg-desktop-portal-kde
    ];
  };
  # programs.hyprlock.enable = true;

  # power saving
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  # server/sync
  services.tailscale.enable = true;
  services.syncthing = {
    enable = true;
    user = "yuni";
    configDir = "/home/yuni/.config/syncthing";
    dataDir = "/home/yuni/Sync";
  };
  programs.localsend.enable = true;

  # fonts
  fonts = {
  fontconfig.enable = true;

  packages = with pkgs; [
      inter
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.iosevka
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      # sarasa-gothic
    ];
  };

  # other
  services.flatpak.enable = true;
  programs.gpu-screen-recorder.enable = true;

  # steam
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  # platformio
  # services.udev.packages = with pkgs; [ 
  #   platformio-core.udev
  #   openocd
  # ];

  # openssh daemon
  services.openssh.enable = true;

  # open ports in the firewall
  # networking.firewall.enable = false;  # disable firewall
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 5353 53317 ];
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
  ];

  # windows partition
  fileSystems."/mnt/win11" = {
    device = "/dev/disk/by-uuid/6A4A1ED74A1E9FBD";
    fsType = "ntfs3";
    options = [ "rw" "uid=1000" "gid=100" "dmask=022" "fmask=133" ];
  };

  # vaapi
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-media-driver
      libva
      libva-utils
    ];
  };

  # bluetooth
  hardware.bluetooth.enable = true;

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
