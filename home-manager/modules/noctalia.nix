{ pkgs, inputs, ... }:
{
  # Оставляем только установку бинарника напрямую из репозитория
  home.packages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

