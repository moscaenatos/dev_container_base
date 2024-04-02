#!/bin/bash
# download MesloLGS NF fonts
wget -P /tmp https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -P /tmp https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -P /tmp https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -P /tmp https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
#  create a directory to store the fonts
mkdir -p ~/.fonts
#  move all the files with .ttf extension to the ~/.fonts directory
mv /tmp/*.ttf ~/.fonts/
#  update the font cache
fc-cache -f -v
# update the terminal.integratedfontFamily setting in vscode and set it MesloLGS NF

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# clone Oh My Zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# ZSH_THEME="powerlevel10k/powerlevel10k" in ~./zshrc
sed -i 's/ZSH_THEME="devcontainers"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# add some useful alias
echo 'alias ls="exa --grid --color auto --icons --sort=type"' >> ~/.zshrc
echo 'alias ll="exa --long --color always --icons --sort=type"' >> ~/.zshrc
echo 'alias la="exa --grid --all --color auto --icons --sort=type"' >> ~/.zshrc
echo 'alias lla="exa --long --all --color auto --icons --sort=type"' >> ~/.zshrc

# add nvm to the .zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc# This loads nvm
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'  >> ~/.zshrc# This loads nvm bash_completion

# add the following to avoid configuring p10k (we are loading it from the .p10k.zsh file)

echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

