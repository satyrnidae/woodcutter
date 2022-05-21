$buildDir = "./.build"

if (-not (Test-Path $buildDir)) {
  New-Item -ItemType Directory $buildDir
}

$packFile = "./pack.mcmeta"

if (Test-Path $packFile) {
  # Load pack json to get file name
  $pack = (Get-Content $packFile | Out-String | ConvertFrom-Json)
  if ($pack.meta.baseArchiveName -and $pack.meta.version) {
    $outFile = "$buildDir/$($pack.meta.baseArchiveName)-$($pack.meta.version).zip"

    if (Test-Path $outFile) {
      Remove-Item $outFile -force
      Write-Output "Removed previous build at $outFile"
    }

    7z a -tzip -i"!$PSScriptRoot/*" -x"!$PSScriptRoot/.*" $outFile
  }
}
