# Nvim Cheat Sheet

This plugin allows you to use cheat sheet ([cht.sh](https://cht.sh/)) inside the vim.

- Plugin written 100 % in lua.
  ![](https://github.com/Djancyp/cheat-sheet/blob/main/images/cheat-sheet.gif)

## Installation

Packer

```bash
use {"Djancyp/cheat-sheet"}
```

## Config

Optionally, you can also pass some configuration to the plugin, here's the default value:

```lua
require("cheat-sheet").setup({
  auto_fill = {
    filetype = true,
    current_word = true,
  },

  main_win = {
    style = "minimal",
    border = "double",
  },

  input_win = {
    style = "minimal",
    border = "double",
  },
})
```

- `auto_fill`:

  - `filetype`: automatically add filetype prefix to search query (ex: `lua/`)
  - `current_word`: automatically add the current word under your cursor to search query

- `main_win`:

  - `style`: main window style (see: `:h nvim_open_win()`)
  - `border`: main window border (see: `:h nvim_open_win()`)

- `input_win`:

  - `style`: input window style (see: `:h nvim_open_win()`)
  - `border`: input window border (see: `:h nvim_open_win()`)

## Usage

```bash
:CheatSH
```

This will open an input window and base on your filetype it will highlight the first part of search. When your query ready just hit the enter.

### Ex:

```
lua/for
```

```
git/pull
```

```
js/async
```

For more information please visit the cheat sheet website - ([cht.sh](https://cht.sh/))

## Keys

```
| Key            | Action                          |
| -------------- | ------------------------------- |
| q              | exit cheat sheet window         |
| <C-c>          | exit input window (input mode)  |
| <C-d>          | remove text (input mode)        |
| `<CR>`(Enter)  | activate the search             |
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
