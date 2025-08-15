sudo apt update

# curl
sudo apt install curl

# gcc (required for neovim plugins)
sudo apt install build-essential

# nvm (for node.js)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22

# wezterm -- https://wezterm.org/install/linux.html
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
sudo apt update
sudo apt install wezterm

# git
sudo apt install git

# neovim
# (this is outdated AF) # sudo apt install neovim
# follow this: https://github.com/neovim/neovim/releases/tag/stable
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
sudo cp -r nvim-linux-x86_64/bin/* /usr/bin
sudo cp -r nvim-linux-x86_64/share/* /usr/share
sudo cp -r nvim-linux-x86_64/lib/* /usr/lib
rm -r nvim-linux-x86_64
rm nvim-linux-x86_64.tar.gz

# projects
mkdir $HOME/projects

## projects/utils
cd $HOME/projects
git clone git@github.com:thiago-negri/utils.git
cd $HOME/projects/utils
./setup_git.sh
git init

## projects/dot-files
cd $HOME/projects
git clone git@github.com:thiago-negri/dot-files.git
cd $HOME/projects/dot-files
./install.sh

# .config/wezterm
git clone git@github.com:thiago-negri/wezterm-config.git $HOME/.config/wezterm

# .config/nvim
git clone git@github.com:thiago-negri/kickstart.nvim.git $HOME/.config/nvim

