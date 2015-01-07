_status_init() {
    _status_line=$(tput lines)
    echo -ne "\e[s\e[1;$[_status_line-1]r\e[u"
}


_status_set() {
    [ -z "$_status_line" ] && _status_init
    _status_data="$(echo -ne "\e[s\e[$_status_line;1H\e[1;44;36m[\e[37m$(date +%H:%M)\e[36m][\e[37mstatus...\e[36m]\e[K\e[u")"
}
_add_prompt_cmd _status_set 99

_winch_hook() {
    local lines=$(tput lines)
    if [ -n "$_status_line" ]; then
	echo -ne "\e[s"
	#if [ "$lines" -le "$_status_line" ]; then
	echo -ne "\e[$lines;1H\e[K"
	#else
	#    echo -ne "\e[$_status_line;1H\e[K"
	#fi
	_status_line=$lines
	echo -ne "\e[1;$[_status_line-1]r"
	echo -ne "\e[u"
    fi
}
trap -- _winch_hook SIGWINCH

PS1="\[\$_status_data\]$PS1"
