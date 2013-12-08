dir=~/dotfiles # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory
files="ackrc bashrc vimrc bash_aliases bash_functions
" # list of files/folders to symlink in homedir
OS=$(lsb_release -si)

# create dotfiles_old in homedir
mkdir -p $olddir

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done


echo "Installing any system dependencies - ^C to cancel"
if [ "$OS" == "Ubuntu" ]; then
    sudo apt-get install exuberant-ctags
else
    sudo yum install exuberant-ctags
fi

echo "Installing VIM bundles"
vim +BundleInstall +qall

source ~/.bashrc
