# aligner.nvim
aligner.nvim is a lightweight Neovim plugin that aligns text

## Usage

<p align="center">
    <img src="https://raw.githubusercontent.com/vzze/aligner.nvim/main/align.gif">
</p>

```lua
vim.api.nvim_create_user_command("Align", "lua require(\"aligner\").align(<line1>, <line2>, <f-args>)",
    { ["range"] = 1, ["nargs"] = 1 })
```

## Installation

### Packer

```lua
use 'vzze/aligner.nvim'

-- lazy loading
use {
    'vzze/aligner.nvim',
    opt = true,
    module = "aligner"
}
```
