{ config, pkgs, ... }: {
  # CONFIG
  services.syncthing = {
    enable = true;

    settings = {
      folders = {
        "lh44t-jvypb" = {
          label = "notes";
          path = "/srv/shared/notes";
          ignorePerms = true;
        };
        "24zlr-3gahc" = {
          label = "uni";
          path = "/srv/shared/uni";
          ignorePerms = true;
        };
        "nyuqt-pvgvq" = {
          label = "music";
          path = "/srv/shared/music";
          ignorePerms = true;
        };
      };
    };
  };

  # USER PERMISSIONS
  users.users.syncthing.extraGroups = [ "srv" ];
}
