DIR=~/dotfiles # dotfiles directory
OLDDIR=~/dotfiles_old # old dotfiles backup directory
# list of files/folders to symlink in homedir
FILES="ackrc bashrc vimrc bash_aliases bash_functions tmux.conf"

mkdir -p $OLDDIR
cd $DIR

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/dotfiles directory specified
# in $files
for file in $FILES; do
    mv ~/.$file $OLDDIR/
    echo "Creating symlink to $file in home directory."
    ln -s $DIR/$file ~/.$file
done

echo "Installing missing any system dependencies - ^C to cancel"
if hash yum 2>/dev/null; then
    sudo yum install ctags python-virtualenvwrapper tmux git ack
else
    sudo apt-get install exuberant-ctags tmux git
fi

echo "Installing VIM bundles"
vim +BundleInstall +qall

source ~/.bashrc

# Use vimdiff for git
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool
git config --global alias.stat status
