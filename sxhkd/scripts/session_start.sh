#!/bin/sh
nitrogen --restore
gocryptfs -extpass 'kdialog --password Files' ~/Private/Drive/Personal ~/Documents &&
    (
    emacs --config tracking & 
    st -e sh ~/.local/scripts/sync.sh &
    gwenview ~/Documents/Org/Tracking/images &
    ) ||
        (
            kdialog --msgbox "Hello Guest";
        )
    
