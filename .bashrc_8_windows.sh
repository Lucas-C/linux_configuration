####################################
# SPECIFIC conf for Windows (Cygwin or Git Bash)
[[ $(uname -s) =~ ^CYGWIN_NT ]] \
    || [[ $(uname -s) =~ ^MINGW32_NT ]] \
    || return 0
####################################

if ! [ -r ~/.dir_colors ]; then
    curl -s 'https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark' > ~/.dir_colors
fi
eval $(SHELL=$SHELL dircolors ~/.dir_colors)

unfuncalias touch

alias psf='ps -ef'
alias node=cyg-node  # in ~/bin
alias sudo='cygstart --action=runas'
alias java_home_win_exec='JAVA_HOME=$(cygpath -w "$JAVA_HOME") '

convertWinArgs () {
    while [ "$1" ]; do
        case $1 in
        /*) echo "$(cygpath -w $1)" ;;
        [A-Z]:*) echo "$1" ;;
        *) echo "$(cygpath -w $PWD/$1)" ;;
        esac
        shift
    done
}

win_hosts=$(cygpath -w "C:\Windows\System32\drivers\etc\hosts")

swap_win_hosts () {
    if ! [ -r $win_hosts.bak ]; then
        echo "Creating $win_hosts.bak"
        echo "127.0.0.1       localhost" > $win_hosts.bak
    fi
    cp $win_hosts tmp1 || return 1
    cp $win_hosts.bak tmp2 || return 2
    mv tmp1 $win_hosts.bak || return 3
    mv tmp2 $win_hosts || return 4
}

[ -r "/cygdrive/c/Program Files (x86)" ] && export X86=\ \(x86\)

npp () {
    "/cygdrive/c/Program Files$X86/Notepad++/notepad++.exe" $(convertWinArgs "$@")
}

pspad () {
    "/cygdrive/c/Program Files$X86/PSPad editor/PSPad" $(convertWinArgs "$@")
}

bat () {
    cmd /c "set PATH=%OLD_PATH% && $@"
}

cdw () {
    cd $(cygpath "$1")
}

firefox () {
    "/cygdrive/c/Program Files$X86/Mozilla Firefox/firefox" $(convertWinArgs "$@")
}

freeplane () {
    "/cygdrive/c/Program Files$X86/Freeplane/freeplane" $(convertWinArgs "$@")
}

unfuncalias nav
nav () {
    local dir="$1"
    [[ $dir == /* ]] || dir="$PWD/$dir"
    explorer /select,$(cygpath -w "$dir/$(ls "$dir" | head -1)")
}

zip () {
    7z a $@
}

unfuncalias pdf
pdf () {
    "/cygdrive/c/Program Files$X86/SumatraPDF/SumatraPDF" $(convertWinArgs "$@")
}

img () {
    rundll32 "C:\Program Files\Windows Photo Viewer\PhotoViewer.dll" ImageView_Fullscreen $(convertWinArgs "$@")
}

#FROM: http://smecsia.me/blog/65/killall+for+cygwin
killall () {
    if [ "$1" = "-9" ]; then
        taskkill /F /IM $2.exe
    else
        taskkill /IM $1.exe
    fi
}

jar_java_version () {
    local jar=$(readlink -f $1)
    cd /tmp
    local a_class=$(jar tf "$(cygpath -w "$jar")" | grep '^[^$]\+.class$' | head -n 1)
    local a_class_main_dir=$(echo "$a_class" | tr '/' '\n' | head -n 1)
    jar xf "$(cygpath -w "$jar")" "$a_class"
    javap -v "$a_class" | grep version
    rm -r $a_class_main_dir
    cd - >/dev/null
}

# Trick from https://github.com/drush-ops/drush/issues/375
# but USING DRUSH WITH CYGWIN IS A BAD IDEA
# and by the way, it invokes bash through msysgit\bin\sh (MINGW32_NT)
alias drush='DRUSH_PHP=php drush'