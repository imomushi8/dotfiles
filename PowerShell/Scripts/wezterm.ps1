# WezTerm向けにcdでディレクトリが変わるたびにカレントディレクトリ情報を送信 (OSC 7)
Function prompt {
    $esc = [char]27
    $osCwd = $PWD.ProviderPath -replace '\\', '/'
    $uri = "file:///$osCwd"
    Write-Host -NoNewline "${esc}]7;${uri}`a"
    $currentDir = Split-Path $executionContext.SessionState.Path.CurrentLocation -Leaf
    return "PS $currentDir$('>' * ($nestedPromptLevel + 1)) "
}

# ls (Get-ChildItem) 時のファイル名背景ハイライトなどをリセットして見やすくする
$PSStyle.FileInfo.Directory = "`e[36m"
$PSStyle.FileInfo.Executable = "`e[32m"
$PSStyle.FileInfo.SymbolicLink = "`e[36m"
$PSStyle.FileInfo.Extension.Clear()