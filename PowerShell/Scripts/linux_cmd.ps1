Set-Alias python3 python
Set-Alias which where.exe
Function touch($file) {
  If (Test-Path $file) {
    (Get-Item $file).LastWriteTime = Get-Date
  } Else {
    Out-File -encoding Default $file
  }
}

Function ln([switch] $s, [string] $filePath, [string] $symlink) {
    if ($s) {
        New-Item -ItemType SymbolicLink -Value $filePath -Path $symlink | Out-Null
    }
    else {
        New-Item -ItemType HardLink -Value $filePath -Path $symlink | Out-Null
    }
}
