_status_set() {
    _status_line=$(tput lines)
    _status_data="$(echo -ne "\e[s\e[1;$[_status_line-1]r\e[$_status_line;1H\e[1;44;36m[\e[37m$(date +%H:%M)\e[36m][\e[37mstatus...\e[36m]\e[K\e[u")"
}
_add_prompt_cmd _status_set 99

_winch_hook() {
    if [ -n "$_status_line" ]; then
	_status_set
	tput ed
	echo -ne "$_status_data"
    fi
}
trap -- _winch_hook SIGWINCH

PS1="\[\$_status_data\]$PS1"
