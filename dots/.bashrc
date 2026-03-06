# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# /----- ALIASES -----/
# Synthax: a name="command"

# Short Utilities (sorted in a-z order)
alias a="alias" # Shortcut to use for every aliases
a c="clear"
a e="echo"
a h="history"
a g="grep"
a f="find"
a k="kill"
a ka="k all"
a l="ls"
a n="nano"
a pk="pkill"
a s="sudo"
a sn="s nano"
a t="touch"

# Alias settings
a aliasc="n $HOME/.bashrc" # Alias change (access this file)
a aliasg="gedit $HOME/.bashrc" # Alias change (gedit)
a aliasr='source $HOME/.bashrc && e "Bash aliases reloaded !"' # Alias reload
a una="unalias"

# /----- FILES -----/

PACKAGE_MANAGER="dnf"

# Package & versions managment
a u="s $PACKAGE_MANAGER update"
a i="s $PACKAGE_MANGER install"
a r="s $PACKAGE_MANGER rm"
a si="s snap install" # install via Snap (not recommended)

# File & Directory
a home="cd $HOME"
a sys="cd /"
a cdp="cd .."
a cdp2="cdp;cdp"
a cdp3="cdp2;cdp"
a cdp4="cdp3;cdp"

# Install dev packages
a isoftwares="i git; i pgadmin4; i snap; si postman"
a ilanguages="i go; i python3"
a idev="isoftwares; ilanguages"

# /----- DOCKER -----/

a d="s docker"
a drun="d run"
a dstop="d stop"
a dexec="d exec -it"
a dc="d compose"
a dcup="dc up"
a dps="d ps"

# /----- HYPRLAND -----/

# Conf Directories Access
a conf="cd ~/.config"
a cdkitty="conf && cd kitty"
a cdwaybar="conf && cd waybar"
a cdrofi="conf && cd rofi"
a cdrofitheme="conf && cd rofi/themes"
a cdhypr="conf && cd hypr"
a cdmenus="conf && cd menus"
a cddiscord="conf && cd discord"
a cdwalllust="conf && cd wallust"
a cdnautilus="conf && cd nautilus"
a cdswappy="conf && cd swappy"

# Conf User Files Access
a cduserconfigs="cdhypr && cd UserConfigs"
a cduserscripts="cdhypr && cd UserScripts"
a cdusercustomscripts="cduserscripts && cd CustomScripts"
a ckeybinds="cduserconfigs && n UserKeybinds.conf"

# Conf Files Access
a ckitty="cdkitty && n kitty.conf"
a chypr="cdhypr && n hyprland.conf"

# Rofi Conf Files Access
a crofi="cdrofi && n config.rasi"
a cmonitors="cdrofi && n config-Monitors.rasi"
a cwallpaper="cdrofi && n config-wallpaper.rasi"
a crofikeybinds="cdrofi && n config-keybinds.rasi"
a cclipboard="cdrofi && n config-clipboard.rasi"
a csearch="cdrofi && n config-search.rasi"
a canimations="cdrofi && n config-Animations.rasi"
a cemoji="cdrofi && n config-emoji.rasi"
a crofibeats="cdrofi && n config-rofi-Beats.rasi"
a crofibeatsmenus="cdrofi && n config-rofi-Beats-menu.rasi"

# Rofi Themes Files Access
a crofitheme="cdrofitheme && n KooL_style-1.rasi"

# Custom scripts
a hyprland-restart="cdusercustomscripts; bash hyprland-restart.sh"

# Waybar
a waybar-start="systemctl --user enable --now waybar.service"
a waybar-stop="killall waybar"
a waybar-restart="waybar-stop; waybar-start"

# /----- OTHER SHORTCUTS -----/

# Lists
a la="l -a" # Show all
a ll="l -la" # Show and list all
a lc="c && l" # Clear and show list
a lca="c && la" # Clear and show all

# ScreenFetch
a sf="screenfetch" # Show ScreenFetch
a sf="sf -s" # Show ScreenFetch and screenshots

# Images
a img="feh" # View image using Feh software

# Network
a ipconfig="ifconfig"
a publicip='curl ipinfo.io/ip' # Print public IP address
a privateip='hostname -I' # Print private IP address
a username="whoami"

# /----- SERVICES -----/

a ctl="s systemctl" # Manage systemd services
a ctle="ctl enable"
a ctlr="ctl reload"
a ctld="ctl disable"
a ctls="ctl start"
a ctlst="ctl status"

# /----- CADDY -----/

CADDY_PATH="/etc/caddy/"
CADDYFILE_PATH="$CADDY_PATH/Caddyfile"

a cdcaddy="cd $CADDY_PATH"
a caddy-conf="cdcaddy; sn Caddyfile"

a caddy-start="ctls caddy"
a caddy-reload="ctlr caddy"
a caddy-enable="ctle caddy"
a caddy-status="ctlst caddy"
a caddy-journal="ctlj caddy"

a caddy-validate="s caddy validate --config $CADDYFILE_PATH"
a caddy-format="cdcaddy; s caddy fmt --overwrite"


# Date
a today='e $(date +%D)' #Today's date

# /----- DEV -----/
a dev='cd $HOME/dev'

# Falloutdle
a falloutdle='dev; cd falloutdle'
a falloutdle-run='c; falloutdle; bash ./run.sh'
a falloutdle-run-help='falloutdle-run -h'
a frun='falloutdle-run'
a frunh="falloutdle-run-help"

#Mesh
a mesh='dev; cd Mesh'
a mesh-run='c; mesh; go run gui/main.go'
a mrun='mesh-run'

# /----- IUT -----/

a cdiut='dev; cd iut'
a cddiut="cdiut; cd docker-web-3a"

# Docker
a dciut="cddiut; dcup --pull always -d --wait"
a dexeciut="dexec docker-web-3a-server-1 bash"
a diut="dciut; dexeciut"