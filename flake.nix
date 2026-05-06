{
  description = "mixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    # laptop
    nixosConfigurations.pasokon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./common/common.nix
        ./hosts/laptop.nix
        ./hardware/laptop.nix

        ./noctalia.nix
        ./services/sddm.nix
      ];
    };

    # pc
    nixosConfigurations.pici = nixpkgs.lib.nixosSystem {
      # to be bought :(
    };

    # server
    nixosConfigurations.saba = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./common/common.nix
        ./hosts/server.nix
        ./hardware/server.nix

        ./services/copyparty.nix
        ./services/syncthing.nix
        ./services/jellyfin.nix
        ./services/immich.nix
      ];
    };
  };
}
