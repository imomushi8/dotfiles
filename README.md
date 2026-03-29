# TODO
- [ ] Terminalで開いたときのTelescopeの設定がうまくいってない

# インストールするもの
- VSCodeを使う場合: Neovimの拡張機能
- `wezterm`

# Windowsのみ初回に実行すること
```powershell
### ※シンボリックリンクを作成するため、管理者権限もしくは開発者モードで開く必要あり。

# クローンした位置を設定
$DOTFILES=<クローンした位置>
New-Item -ItemType SymbolicLink -Value $DOTFILES\PowerShell -Path $PROFILE\..\ | Out-Null

# プロファイルの変更を反映
. $PROFILE
```

# 必要なもののみ、以下でシンボリックリンクを作成
```sh
# Neovim
ln -s $DOTFILES/nvim $XDG_CONFIG_HOME/nvim

# WezTerm
ln -s $DOTFILES/wezterm $XDG_CONFIG_HOME/wezterm

# Emacs
ln -s $DOTFILES/emacs $XDG_CONFIG_HOME/emacs
```
