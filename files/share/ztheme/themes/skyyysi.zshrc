# My personal prompt theme, based on https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/gentoo.zsh-theme
function prompt_character {
	if [ $UID -eq 0 ];
		then
			echo "#";
		else
			echo "$";
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
PROMPT='%{$fg_bold[yellow]%}%T%{$fg_bold[white]%} - %{$fg_bold[$(prompt_color)]%}%n@%m %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)$(prompt_character)%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
