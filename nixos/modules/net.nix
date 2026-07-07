{ inputs, ... } : 
{
  imports = [ "${inputs.happ-nixos}/happ-module.nix" ];
  
  networking.networkmanager.enable = true;

  services.happ.enable = true;
}
