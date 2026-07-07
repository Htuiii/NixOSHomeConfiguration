{ pkgs, config, ... }: {

  # 1. Говорим Nix: взять папку ./jblicense и положить её в ~/.config/ja-netfilter
  # В xdg.configFile имя атрибута — это путь ВНУТРИ папки ~/.config/
  xdg.configFile."ja-netfilter".source = ./jblicense;

  # 2. Устанавливаем чистый пакет pycharm-professional
  home.packages = [
    pkgs.jetbrains.pycharm-professional
  ];

  # 3. Переменная окружения указывает PyCharm, откуда брать vmoptions
  home.sessionVariables = {
    PYCHARM_VM_OPTIONS = "${config.home.homeDirectory}/.config/ja-netfilter/pycharm_custom.vmoptions";
  };

  # 4. Чтобы файл лег прямо в ~/.config/ja-netfilter/pycharm_custom.vmoptions,
  # мы заставим Nix сгенерировать его через блок home.file, указав полный путь от самого $HOME.
  # Так мы гарантированно избежим путаницы с путями xdg!
  home.file.".config/ja-netfilter/pycharm_custom.vmoptions".text = ''
    -javaagent:${config.home.homeDirectory}/.config/ja-netfilter/ja-netfilter.jar=jetbrains
    --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
    --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
  '';
}

