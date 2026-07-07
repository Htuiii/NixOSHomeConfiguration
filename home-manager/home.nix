{ user, ... }: {
  imports = [
    ./modules
    ./home-packages.nix
   
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.11";
  };
  
}
