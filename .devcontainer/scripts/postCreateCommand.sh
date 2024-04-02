#!/bin/bash

#invoke install_ohmyzsh_font.sh
/home/vscode/scripts/install_ohmyzsh_font.sh

# restart zsh and invoke init.sh 

exec zsh -l -c '/home/vscode/scripts/init.sh'
```