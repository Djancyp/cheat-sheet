# Nvim Cheat Sheet

This plugin allows you to use cheat sheet ([cht.sh](https://cht.sh/)) inside the vim.

- Plugin written  100 % in lua. 
![](https://github.com/Djancyp/cheat-sheet/blob/main/images/cheat-sheet.gif)

## Installation

Packer

```bash
use {"Djancyp/cheat-sheet"}
```

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
For more information please visit the cheat sheet website -  ([cht.sh](https://cht.sh/))

## Keys
```
| Key            | Action                          |
| -------------- | ------------------------------- |
| q              | exit cheat sheet window         |
| `<CR>`(Enter)  | activate the seah               |
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
