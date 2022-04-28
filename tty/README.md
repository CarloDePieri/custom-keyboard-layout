## HOW TO

```
mkdir -p /usr/local/share/kbd/keymaps
cp us_cik.map /usr/local/share/kbd/keymaps/.
```

Then, to try it (it needs the absolute path!):

```
loadkeys /usr/local/share/kbd/keymaps/us_cik.map
```

To set it permanently:

```
localectl set-keymap --no-convert /usr/local/share/kbd/keymaps/us_cik.map
```

## NOTE

This is taken from the `/usr/share/kbd/keymaps/i386/qwerty/us.map.gz`.
These are **NOT** X keycodes. Don't use `xev`. Look at the included maps at the
top of the files for keycodes.

## SOURCES

[arch wiki](https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration)
[man keymaps](https://man.archlinux.org/man/keymaps.5)
