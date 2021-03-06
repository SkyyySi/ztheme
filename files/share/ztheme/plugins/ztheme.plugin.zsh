### Loader

# Since it is annoying to run "source /usr/bin/ztheme <theme name>" every time,
# this script will alias itself.
if [ -f "/usr/bin/ztheme" ]; then
	alias ztheme="source /usr/bin/ztheme"
fi

# If you want to, you can define the variable "$ZTHEME_PREFIX" in your ~/.zshrc
# to use another folder to store settings, themes and plugins.
# For example, you might want to move the folder to .config or .dots
if [ -z "$ZTHEME_PREFIX" ]; then
	ZTHEME_PREFIX="$HOME/.zsh"
fi

### Define system directorys

# Check if system plugin directory exists.
# If yes, use it, otherwise an error occured during install.
if [ -z "$ZTHEME_SYSTEM_PLUGIN_DIR" ]; then
	ZTHEME_SYSTEM_PLUGIN_DIR="/usr/share/ztheme/plugins"
fi

# Check if system library directory exists.
# If yes, use it, otherwise an error occured during install.
if [ -z "$ZTHEME_SYSTEM_LIB_DIR" ]; then
	ZTHEME_SYSTEM_LIB_DIR="/usr/share/ztheme/lib"
fi

# Check if system theme directory exists.
# If yes, use it, otherwise an error occured during install.
if [ -z "$ZTHEME_SYSTEM_THEME_DIR" ]; then
	ZTHEME_SYSTEM_THEME_DIR="/usr/share/ztheme/themes"
fi

### Define user directorys

# Check if user config directory exists.
# If yes, use it, otherwise create it.
if [ -z "$ZTHEME_USER_CONFIG_DIR" ]; then
	if [ -d "$ZTHEME_PREFIX/ztheme/" ]; then
		ZTHEME_USER_CONFIG_DIR="$ZTHEME_PREFIX/ztheme";
	else
		mkdir -p "$ZTHEME_PREFIX/ztheme/";
		ZTHEME_USER_CONFIG_DIR="$ZTHEME_PREFIX/ztheme";
	fi
fi

# Check if user plugin directory exists.
# If yes, use it, otherwise create it.
if [ -z "$ZTHEME_USER_PLUGIN_DIR" ]; then
	if [ -d "$ZTHEME_PREFIX/plugins/" ]; then
		ZTHEME_USER_PLUGIN_DIR="$ZTHEME_PREFIX/plugins";
	else
		mkdir -p "$ZTHEME_PREFIX/ztheme/";
		ZTHEME_USER_PLUGIN_DIR="$ZTHEME_PREFIX/plugins";
	fi
fi

# Check if user theme directory exists.
# If yes, use it, otherwise create it.
if [ -z "$ZTHEME_USER_THEME_DIR" ]; then
	if [ -d "$ZTHEME_PREFIX/themes/" ]; then
		ZTHEME_USER_THEME_DIR="$ZTHEME_PREFIX/themes";
	else
		mkdir -p "$ZTHEME_PREFIX/themes/";
		ZTHEME_USER_THEME_DIR="$ZTHEME_PREFIX/themes";
	fi
fi

### Plugins

# Clean the previous plugin list
if [ -n "$ZTHEME_PLUGIN" ]; then
	ZTHEME_PLUGIN="";
fi

# Load the plugin list
if [ -f "$ZTHEME_USER_CONFIG_DIR/.ztheme_plugins" ]; then
	source "$ZTHEME_USER_CONFIG_DIR/.ztheme_plugins";
fi

# Source system plugin librarys
if [ -n "$ZTHEME_SYSTEM_LIBRARY" ]; then
	ZTHEME_SYSTEM_LIBRARY="";
fi

for ZTHEME_SYSTEM_LIBRARY in $ZTHEME_SYSTEM_LIB_DIR/*.zsh; do
	source "$ZTHEME_SYSTEM_LIBRARY";
done

# Source the plugin files
for ZTHEME_PLUGIN ($ZTHEME_PLUGINS); do
  if [ -f "$ZTHEME_USER_PLUGIN_DIR/$ZTHEME_PLUGIN/$ZTHEME_PLUGIN.plugin.zsh" ]; then
    source "$ZTHEME_USER_PLUGIN_DIR/$ZTHEME_PLUGIN/$ZTHEME_PLUGIN.plugin.zsh"
  elif [ -f "$ZTHEME_USER_PLUGIN_DIR/$ZTHEME_PLUGIN.plugin.zsh" ]; then
    source "$ZTHEME_USER_PLUGIN_DIR/$ZTHEME_PLUGIN.zsh"
  elif [ -f "$ZTHEME_SYSTEM_PLUGIN_DIR/$ZTHEME_PLUGIN/$ZTHEME_PLUGIN.plugin.zsh" ]; then
    source "$ZTHEME_SYSTEM_PLUGIN_DIR/$ZTHEME_PLUGIN/$ZTHEME_PLUGIN.plugin.zsh"
  elif [ -f "$ZTHEME_SYSTEM_PLUGIN_DIR/$ZTHEME_PLUGIN.plugin.zsh" ]; then
    source "$ZTHEME_SYSTEM_PLUGIN_DIR/$ZTHEME_PLUGIN.plugin.zsh"
  fi
done

### Load the configs

# Source the default/fallback prompt which is used if the stored settings contain an error.
# If you want a diffrent fallback prompt, change $ZTHEME_USER_THEME_DIR/default.zshrc
if [ -f "$ZTHEME_USER_THEME_DIR/default.zshrc" ]; then
	source "$ZTHEME_USER_THEME_DIR/default.zshrc";
elif [ -f "$ZTHEME_SYSTEM_THEME_DIR/default.zshrc" ]; then
	source "$ZTHEME_SYSTEM_THEME_DIR/default.zshrc";
else
	export PROMPT="%m%# ";
fi

# Wirte the last used theme into the variable "$ZSH_THEME",
# which gets used right below this here.
if [ -f "$ZTHEME_USER_CONFIG_DIR/.ztheme_prompt" ]; then
	source "$ZTHEME_USER_CONFIG_DIR/.ztheme_prompt";
fi

# Restore the selected prompt theme, overwriting the fallback from above.
if [ -n "$ZTHEME_PROMPT" ]; then
	if [ -f "$ZTHEME_USER_THEME_DIR/$ZTHEME_PROMPT.zshrc" ]; then
		source "$ZTHEME_USER_THEME_DIR/$ZTHEME_PROMPT.zshrc";
	elif [ -f "$ZTHEME_SYSTEM_THEME_DIR/$ZTHEME_PROMPT.zshrc" ]; then
		source "$ZTHEME_SYSTEM_THEME_DIR/$ZTHEME_PROMPT.zshrc";
	fi
fi

### Info

# Show the current theme when opening a new terminal
# Only run these commands if the user is not logged in as root, as it is
# very annoing to see this whenever you type "sudo -i"
if [ ! $UID -eq 0 ]; then
	if [ -f "$ZTHEME_USER_THEME_DIR/$ZTHEME_PROMPT.zshrc" ]; then
		BOLD="\033[1m";
		NORMAL="\033[0m";
		echo "The current theme is: ${BOLD}'${ZTHEME_PROMPT}'${NORMAL}! \n";
	elif [ -f "$ZTHEME_SYSTEM_THEME_DIR/$ZTHEME_PROMPT.zshrc" ]; then
		BOLD="\033[1m";
		NORMAL="\033[0m";
		echo "The current theme is: ${BOLD}'${ZTHEME_PROMPT}'${NORMAL}! \n";
	else
		COLOR="\033[0;31m";
		NORMAL="\033[0m";
		BOLD="\033[1m";
		echo "${COLOR}Invalid or no theme provided! \n${NORMAL}Please check that ${BOLD}'${ZTHEME_USER_THEME_DIR}/${ZTHEME_PROMPT}.zshrc'${NORMAL} and/or ${BOLD}'${ZTHEME_SYSTEM_THEME_DIR}/${ZTHEME_PROMPT}.zshrc'${NORMAL} exists and that ${BOLD}'${ZTHEME_USER_CONFIG_DIR}/.ztheme'${NORMAL} contains a valid theme name! \nLoading default theme... ";
	fi
fi
