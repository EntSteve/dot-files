source /usr/share/cachyos-fish-config/cachyos-config.fish
set --universal nvm_default_version lts
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
starship init fish | source
