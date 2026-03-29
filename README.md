# 初回に実行すること
```powershell
### ※シンボリックリンクを作成するため、管理者権限もしくは開発者モードで開く必要あり。

# クローンした位置を設定
$env:DOTFILES = <クローンした位置>

# PowerShell
New-Item -ItemType SymbolicLink -Value $env:DOTFILES\PowerShell -Path $PROFILE\../ | Out-Null
. $PROFILE

# Neovim
ln -s $env:DOTFILES\nvim $env:XDG_CONFIG_HOME\nvim

# WezTerm
ln -s $env:DOTFILES\wezterm $env:XDG_CONFIG_HOME\wezterm
```
