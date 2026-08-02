#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

$TargetDir = "$ProjectRoot\dist\banhmivim"
$BundleConfig = "$TargetDir\config"
$BinDir = "$TargetDir\bin"
$LspDir = "$TargetDir\lsp"
$CacheDir = "$ProjectRoot\.bmcache"

$ZigVersion = "0.16.0"
$ZigUrl = "https://ziglang.org/download/${ZigVersion}/zig-x86_64-windows-${ZigVersion}.zip"
$ZigZipName = "zig-windows-x86_64-${ZigVersion}.zip"

$TsCliVersion = "0.26.11"
$TsCliUrl = "https://github.com/tree-sitter/tree-sitter/releases/download/v${TsCliVersion}/tree-sitter-windows-x64.gz"
$TsCliGzName = "tree-sitter-windows-x64-v${TsCliVersion}.gz"

Write-Host "Creating bundle structure at: $TargetDir"
New-Item -ItemType Directory -Path $BundleConfig -Force | Out-Null
New-Item -ItemType Directory -Path $BinDir -Force | Out-Null
New-Item -ItemType Directory -Path $CacheDir -Force | Out-Null

# Copy config files (from banhmivim/config/ into dist/banhmivim/config/)
Copy-Item -Path "$ProjectRoot\banhmivim\config\*" -Destination $BundleConfig -Recurse -Force

Copy-Item -Path "$ProjectRoot\banhmivim\bin\banhmivim.cmd" -Destination $BinDir -Force

Copy-Item -Path "$ProjectRoot\scripts\zig.bat" -Destination $BinDir -Force
Copy-Item -Path "$ProjectRoot\scripts\zigcc.bat" -Destination $BinDir -Force

# ---- Zig Compiler ----
Write-Host "--- Processing Zig Compiler (v${ZigVersion}) ---"
New-Item -ItemType Directory -Path "$BinDir\zig-dist" -Force | Out-Null

$ZigCachePath = "$CacheDir\$ZigZipName"
if (-not (Test-Path $ZigCachePath)) {
    Write-Host "Cache miss: Downloading Zig..."
    Invoke-WebRequest -Uri $ZigUrl -OutFile $ZigCachePath
} else {
    Write-Host "Cache hit: Using cached Zig archive."
}

Write-Host "Extracting Zig to bundle..."
# zig zip contains a single top-level folder (e.g. zig-windows-x86_64-0.16.0/)
# We strip it by extracting contents directly into bin/zig
$TempZig = [System.IO.Path]::GetTempPath() + [System.Guid]::NewGuid().ToString()
New-Item -ItemType Directory -Path $TempZig -Force | Out-Null
try {
    Expand-Archive -Path $ZigCachePath -DestinationPath $TempZig -Force
    $ZigSubDir = Get-ChildItem -Path $TempZig -Directory | Select-Object -First 1
    if ($ZigSubDir) {
        Get-ChildItem -Path $ZigSubDir.FullName | Copy-Item -Destination "$BinDir\zig-dist" -Recurse -Force
    }
} finally {
    Remove-Item -Path $TempZig -Recurse -Force -ErrorAction SilentlyContinue
}

# ---- Tree-sitter CLI ----
Write-Host "--- Processing Tree-sitter CLI (v${TsCliVersion}) ---"

$TsCachePath = "$CacheDir\$TsCliGzName"
if (-not (Test-Path $TsCachePath)) {
    Write-Host "Cache miss: Downloading Tree-sitter CLI..."
    Invoke-WebRequest -Uri $TsCliUrl -OutFile $TsCachePath
} else {
    Write-Host "Cache hit: Using cached Tree-sitter CLI archive."
}

Write-Host "Extracting Tree-sitter CLI to bundle..."
$TsOutPath = "$BinDir\tree-sitter.exe"
# tree-sitter-windows-x64.gz is a gzipped executable
$TempTsFile = "$CacheDir\tree-sitter-temp.exe"
if (Test-Path $TempTsFile) { Remove-Item $TempTsFile -Force }

# Use .NET GZipStream to decompress
$InputStream = [System.IO.File]::OpenRead($TsCachePath)
$OutputStream = [System.IO.File]::Create($TempTsFile)
$GzipStream = New-Object System.IO.Compression.GZipStream($InputStream, [System.IO.Compression.CompressionMode]::Decompress)
try {
    $GzipStream.CopyTo($OutputStream)
} finally {
    $GzipStream.Close()
    $OutputStream.Close()
    $InputStream.Close()
}

Move-Item -Path $TempTsFile -Destination $TsOutPath -Force

Write-Host "Bundle successfully built!"
