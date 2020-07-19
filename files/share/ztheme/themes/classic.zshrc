function prompt_character {
	if [ $UID -eq 0 ];
		then
			echo "#";
		else
			echo $;
	fi
}

function prompt_color {
	if [ $UID -eq 0 ];
		then
			echo "red";
		else
			echo "green";
	fi
}

autoload -U colors && colors
PROMPT="%{$fg_bold[$(prompt_color)]%}%n@%m %{$fg_bold[blue]%}%~ $(prompt_character)%{$reset_color%} ";
