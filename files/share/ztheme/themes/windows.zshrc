# Based on https://github.com/juliavallina/windows-zsh-theme/blob/master/windows.zsh-theme

setopt PROMPT_SUBST
PROMPT="C:%{${${(%):-%/}//\//\\}%${#${${(%):-%/}//\//\\}}> "
