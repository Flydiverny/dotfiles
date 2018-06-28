#!/bin/sh
if test "$(which code)"; then
	if [ "$(uname -s)" = "Darwin" ]; then
		VSCODE_HOME="$HOME/Library/Application Support/Code"
	else
		VSCODE_HOME="$HOME/.config/Code"
	fi

	ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
	ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
	ln -sfh "$DOTFILES/vscode/snippets" "$VSCODE_HOME/User/snippets"

	# from `code --list-extensions`
	modules="
CoenraadS.bracket-pair-colorizer
EditorConfig.EditorConfig
GrapeCity.gc-excelviewer
IBM.output-colorizer
KnisterPeter.vscode-github
PeterJausovec.vscode-docker
WallabyJs.quokka-vscode
Zignd.html-css-class-completion
chong.vscode-typescript-react-redux-snippets
christian-kohler.npm-intellisense
christian-kohler.path-intellisense
cmstead.jsrefactor
cssho.vscode-svgviewer
cuneyt-aliustaoglu.vscode-react-proptypes-intellisense
dbaeumer.vscode-eslint
deerawan.vscode-dash
eamodio.gitlens
eg2.vscode-npm-script
emilast.LogFileHighlighter
esbenp.prettier-vscode
formulahendry.auto-close-tag
formulahendry.auto-rename-tag
foxundermoon.shell-format
jakob101.RelativePath
joshpeng.theme-charcoal-oceanicnext
joshpeng.theme-onedark-sublime
jpoissonnier.vscode-styled-components
kamikillerto.vscode-colorize
mgmcdermott.vscode-language-babel
mikestead.dotenv
minhthai.vscode-todo-parser
mrmlnc.vscode-apache
ms-vsliveshare.vsliveshare
msjsdiag.debugger-for-chrome
pflannery.vscode-versionlens
robertohuertasm.vscode-icons
smelukov.vscode-csstree
sourcegraph.javascript-typescript
technosophos.vscode-helm
timonwong.shellcheck
wayou.vscode-todo-highlight
ziyasal.vscode-open-in-github
"
	for module in $modules; do
		code --install-extension "$module" || true
	done
fi
