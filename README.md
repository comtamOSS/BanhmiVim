# BanhmiVim

Instant Neovim IDE just work (for me)

> [!WARNING]
> Nothing work yet

## Why?

YES

How long you want to spend to setup your neovim in new computer, all day, or just minute. How about the number of keystroke to do so.

## Setup alias

### Linux
### Windows
#### 1. Download
#### 2. Put the path to bin folder to system variable PATH
#### 3. Set CC variable
The tree-sitter-cli in windows build need the cl.exe from MSVC build toolchain. But here we going to use Zig compiler. So we need to pypass it. You will set the system variable `CC` to `zigcc.bat`.

Step-by-step:

1. Search in windows, `System Properties` -> `Environment Variable` -> `System variables` -> `New...`
2. Variable name: CC
3. Variable value: zigcc.bat
4. Ok

#### 4. Now you good, enjoy your banhmi


<!-- ```ps1 -->
<!-- function banhmivim { -->
<!--     & "D:\<PATH>\BanhmiVim\banhmivim\banhmivim.ps1" @args -->
<!-- } -->
<!-- ``` -->

## UI

### Fonts

## Keymap

## Extras

## LSP

## DAP

> Comming soon
