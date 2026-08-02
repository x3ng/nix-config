{ ... }:
{
  # 显式声明 shell 集成：行为钉死，不依赖 home-manager 全局默认
  # （home.shell.enableShellIntegration 未来若翻转默认值，这里不受影响）
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
