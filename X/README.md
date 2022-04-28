Copy this .Xmodmap file in your home:

```
cp .Xmodmap ~/.
```

Add the following section to `/usr/share/X11/xkb/symbols/us`:

```
partial alphanumeric_keys
xkb_symbols "cik" {

    include "us(basic)"
    name[Group1]= "English (US, cik)";

    //hjkl
    //AltGr + hjkl
    key <AC06> {        [         h, H, Left            ]       };
    key <AC07> {        [         j, J, Down            ]       };
    key <AC08> {        [         k, K, Up              ]       };
    key <AC09> {        [         l, L, Right           ]       };

    include "level3(ralt_switch)"
};
```

In .xinitrc / .xprofile add:

```
setxkbmap us -v cik
xmodmap ~/.Xmodmap
```
