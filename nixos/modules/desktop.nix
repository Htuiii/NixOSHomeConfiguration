{ pkgs, ... }:

{
  # Автомонтирование дисков
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Thunar и его плагины
  programs.thunar.plugins = with pkgs.xfce; [ thunar-volman ];

  environment.systemPackages = with pkgs; [
    ntfs3g     # для NTFS
    exfatprogs # для exFAT
    yad       # если нужен для GUI-диалогов
  ];
}