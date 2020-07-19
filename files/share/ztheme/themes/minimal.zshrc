function prompt_color {
	if [ $UID -eq 0 ];
		then
			echo "red";
		else
			echo "green";
	fi
}

autoload -U colors && colors
PROMPT="%{$fg_bold[blue]%}%~%{$fg_bold[$(prompt_color)]%} >%{$reset_color%} "
