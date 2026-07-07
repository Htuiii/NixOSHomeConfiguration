{ pkgs, config, ... }:

{
  # Видеокарта и 32-битные библиотеки
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Docker
  virtualisation.docker.enable = true;

  # Gamescope
  programs.gamescope.enable = true;
  users.users.htuiii.extraGroups = [ "docker" ];
}