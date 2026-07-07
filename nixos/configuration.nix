# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://nixos.org and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./happ-nixos/happ-module.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # РАЗРЕШАЕМ НЕБЕСПЛАТНЫЙ СОФТ (Нужно для PyCharm, Telegram, Steam)
  nixpkgs.config.allowUnfree = true;
  services.happ.enable = true;
  # Включаем официальный модуль Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; 
  };

  # Подсказка для Chromium/Electron использовать Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # СИСТЕМНЫЙ СЕРВИС: Включаем Docker
  virtualisation.docker.enable = true;
  
  # СИСТЕМНЫЙ МОДУЛЬ: Включаем Steam (автоматически настроит 32-битные библиотеки)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  # Спящий режим
  services.logind.extraConfig = "
      HandleLidSwitch=suspend
      HandleLidSwitchExternalPower=suspend
      HandleLidSwitchDocked=ignore
    "; 
  # Видевокарта
  hardware.graphics = {
      enable = true;
      enable32Bit = true; # Важно для Proton/Steam!
  };

  # Настройка звука через PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Настройка беспроводной связи Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true; 

  # Настройка тачпада (включаем на уровне системы)
  services.libinput.enable = true;
   
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.htuiii = {
    isNormalUser = true;
    home = "/home/htuiii";
    description = "main Account";
    # Добавляем группы для управления контейнерами, видео и вводом без sudo
    extraGroups = [ "wheel" "video" "input" "docker" ]; 
  };
  # Включение службы монтирования udisks2
  services.udisks2.enable = true;
  programs.gamescope.enable = true;
  # Включение виртуальной файловой системы gvfs (необходима для Thunar)
  services.gvfs.enable = true;

  # Дополнительно: поддержка автомонтирования в Thunar
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];

  # Список всех установленных программ в системе
  environment.systemPackages = with pkgs; [
    # Твоя старая база
    vim git chromium xfce.mousepad
    wine
    winetricks
    ntfs3g       		# Для поддержки NTFS
    exfatprogs                  # Для поддержки exFAT
    slurp			#screenshots
    grim			#screenshots 
    unzip			#для зипок
    # Окружение Hyprland
    kitty waybar rofi-wayland mako swww brightnessctl yad blueman
    home-manager
    # ТВОЙ НОВЫЙ РАБОЧИЙ НАБОР ДЛЯ 12 БИЛДА:
    telegram-desktop            # Телеграм
    jetbrains.pycharm-community  # PyCharm (Community Edition)
    libreoffice-fresh           # Офисный пакет (Вместо Word/Excel)
    python3                     # Сам Python для работы в PyCharm
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.thunar.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}

