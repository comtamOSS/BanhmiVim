$BMVIM_SCRIPT_DIR = $PSScriptRoot

$BMVIM_DATA_PATH  = "$HOME\.banhmivim\data"
$BMVIM_STATE_PATH = "$HOME\.banhmivim\state"
$BMVIM_CACHE_PATH = "$HOME\.banhmivim\cache"

$env:NVIM_APPNAME = "banhmivim"

$env:XDG_CONFIG_HOME = "$BMVIM_SCRIPT_DIR\config"
$env:XDG_DATA_HOME   = $BMVIM_DATA_PATH
$env:XDG_STATE_HOME  = $BMVIM_STATE_PATH
$env:XDG_CACHE_HOME  = $BMVIM_CACHE_PATH

& nvim @args
