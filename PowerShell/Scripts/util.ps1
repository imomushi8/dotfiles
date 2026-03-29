Function Rename-Successively($ext, $header){
  ls -File $ext | sort Time | % {$i = 1} {
    $Newname = $header + $i.tostring("000") + $_.extension;
    Rename-Item $_ $Newname;
    $i++
  }
}

Function Convert-Extension($oldExt, $newExt){
  Get-ChildItem -File -Name| Rename-Item -NewName { $_ -replace $oldExt, $newExt }
}

Set-Alias convert Convert-Extension
Set-Alias rs Rename-Successively
