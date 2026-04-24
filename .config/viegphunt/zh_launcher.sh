#!/usr/bin/env bash
awk -F= '
    /^Name\[zh_CN\]=/ { zh[FILENAME]=$2; next }
    /^Name=/ && !/^Name\[/ { en[FILENAME]=$2 }
    ENDFILE {
        basename = FILENAME
        sub(/.*\//, "", basename)
        display = (FILENAME in zh) ? zh[FILENAME] : en[FILENAME]
        if (display) printf "%s\t%s\n", display, basename
    }
' /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop 2>/dev/null | sort -t$'\t' -k1,1 -u | \
fzf --prompt="Open > " \
    --layout=reverse \
    --border=rounded \
    --border-label=" Application Launcher " \
    --delimiter=$'\t' \
    --with-nth=1 \
    --color="bg+:#313244,bg:#1e1e2e,fg:#cdd6f4,fg+:#cdd6f4,hl:#89b4fa,hl+:#89b4fa,border:#585b70,prompt:#cba6f7,pointer:#f5c2e7,marker:#a6e3a1,spinner:#fab387,header:#f9e2af,gutter:#45475a,info:#a6e3a1,query:#cdd6f4" \
    --bind "enter:become(echo {2})" \
    --no-info
