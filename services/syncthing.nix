{ config, pkgs, ... }: {
  # CONFIG
  services.syncthing = {
    enable = true;

    settings = {
      folders = {
        "notes" = {
          path = "/srv/shared/notes";
          ignorePerms = true;
        };
        "uni" = {
          path = "/srv/shared/uni";
          ignorePerms = true;
        };
        "music" = {
          path = "/srv/shared/music";
          ignorePerms = true;
        };
      };
    };
  };

  # USER PERMISSIONS
  users.users.syncthing.extraGroups = [ "srv" ];
}
