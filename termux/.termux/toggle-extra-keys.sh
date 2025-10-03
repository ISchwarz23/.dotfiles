#!/data/data/com.termux/files/usr/bin/bash
# Toggle Termux extra keys

CONFIG="$HOME/.termux/termux.properties"
ON_CONF="extra-keys = [ [ 'ESC','/','-','HOME','UP','END','PGUP' ], [ 'TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN' ] ]"
OFF_CONF="extra-keys = []"

# If config has [] → turn ON, else → turn OFF
if grep -q "extra-keys = \[\]" "$CONFIG"; then
    echo "$ON_CONF" > "$CONFIG"
    echo "Extra keys enabled"
else
    echo "$OFF_CONF" > "$CONFIG"
    echo "Extra keys disabled"
fi

termux-reload-settings
