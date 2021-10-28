#!/bin/bash
source ./utils.sh

export DEBIAN_FRONTEND=noninteractive


print_in_purple "\n   apt upgrade"
seek_confirmation "   Warning: Are you sure you want to run 'sudo apt update'?\n You may want to have some tea ☕."
if is_confirmed; then
    # sudo apt update
    # sudo apt upgrade -y
    execute "sudo apt update" "apt update"
    sudo apt upgrade -y
fi


#  Git
print_in_purple "\n   git\n\n"
install_package "Git" "git"
# ZSH
./install-zsh.sh

print_in_purple "\n   curl\n\n"
install_package "curl" "curl"

print_in_purple "\n   tree\n\n"
install_package "tree" "tree"

print_in_purple "\n   jq\n\n"
install_package "jq" "jq"

print_in_purple "\n   xclip\n\n"
install_package "xclip" "xclip"

print_in_purple "\n   zip\n\n"
install_package "zip" "zip"
install_package "zip" "unzip"


print_in_purple "\n   python\n\n"
install_package "python" "python"
install_package "python-pip" "python-pip -y"

# print_in_purple "\n   Rust compiler & package manager\n\n"

# execute "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash /dev/stdin -y"
# source $HOME/.cargo/env

# print_in_purple "\n   diffr\n\n"
# # Diff tool
# execute "cargo install diffr"

print_in_purple "\n   vim\n\n"
install_package "vim" "vim-gnome -y"

print_in_purple "\n   tmux\n\n"
install_package "tmux" "tmux"


print_in_purple "\n   shell-check\n\n"
install_package "ShellCheck" "shellcheck"

print_in_purple "\n   node\n\n"
if which node > /dev/null
    then
            execute "" "node (already installed), $(node -v)"
    else
    execute "curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash - &>/dev/null" "updating node based on https://deb.nodesource.com/setup_13.x"
    install_package "nodejs" "nodejs"
fi

print_in_purple "\n   NPM\n\n"

sudo npm ls -g npm > /dev/null
if [[ $? -ne 0 ]]; then
    install_npm_package "npm" "npm"
else
    # print_in_yellow "   already installed\n"
    execute "" "npm (already installed), $(npm -v)"
fi

print_in_purple "\n   yo\n\n"
sudo npm ls -g yo > /dev/null
if [[ $? -ne 0 ]]; then
    install_npm_package "yo" "yo"
else
    execute "" "yo (already installed)"
fi

print_in_purple "\n   jira-cmd\n\n"
sudo npm ls -g yo > /dev/null
if [[ $? -ne 0 ]]; then
    install_npm_package "jira-cmd" "jira-cmd"
else
    execute "" "jira-cmd (already installed)"
fi

# Ruby
./install-ruby.sh
# Exa (list your files in a cool way)
EXA_BUILD="exa-linux-x86_64"
print_in_purple "\n   $EXA_BUILD\n\n"
EXA_FILENAME="exa-linux-x86_64-0.9.0.zip"
EXA_URL="https://github.com/ogham/exa/releases/download/v0.9.0/$EXA_FILENAME"
execute "curl -sL $EXA_URL -o \"/tmp/$EXA_FILENAME\"" "exa"
unzip "/tmp/$EXA_FILENAME" -d /tmp &>/dev/null
sudo mv "/tmp/$EXA_BUILD" /usr/local/bin/exa
# dotnet
./install-dotnet.sh
# docker
./install-docker.sh

# TODO: apply this fix if needed in proper place (Permission denied fix)
# sudo chown -R $(whoami) /home/nikiforovall/.config/
