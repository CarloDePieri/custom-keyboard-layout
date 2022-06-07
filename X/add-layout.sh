#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "[ERR] I need to run as root!"
  exit 1
fi

us="/usr/share/X11/xkb/symbols/us"
it="/usr/share/X11/xkb/symbols/it"

has_my_keymap() {
  set +e
  check=$(cat "$1" | grep cik)
  set -e
  [[ $check != "" ]]
}

# US KEYMAP INJECTION
if has_my_keymap $us; then
  echo "[SKIP] us keymap already up-to-date!"
else
  cat <<EOT >> $us

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
EOT
  echo "[DONE] us keymap injected!"
fi

# ITALIAN KEYMAP INJECTION
if has_my_keymap $it; then
  echo "[SKIP] it keymap already up-to-date!"
else
  cat <<EOT >> $it

partial alphanumeric_keys
xkb_symbols "cik" {
    include "it(basic)"
    name[Group1]= "Italian (cik)";

    //hjkl
    //AltGr + hjkl
    key <AC06> {        [         h, H, Left            ]       };
    key <AC07> {        [         j, J, Down            ]       };
    key <AC08> {        [         k, K, Up              ]       };
    key <AC09> {        [         l, L, Right           ]       };
};
EOT
  echo "[DONE] it keymap injected!"
fi

# ENABLE THE KEYMAPS
setxkbmap us,it -v cik,cik -option
setxkbmap us,it -v cik,cik -option grp:ctrls_toggle
echo "[DONE] keyboard layouts set via setxkbmap!"

echo ""
echo "IMPORTANT: cp .Xmodmap ~/. && xmodmap ~/.xmodmap"

# TELL HOW TO PERSIST THEM
echo ""
echo "Make sure to persist them by adding these lines in your .xinitrc / .xprofile:"
echo ""
echo "setxkbmap us,it -v cik,cik -option grp:ctrls_toggle"
echo "xmodmap ~/.Xmodmap"
