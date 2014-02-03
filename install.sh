DIR=~/dotfiles # dotfiles directory
OLDDIR=~/dotfiles_old # old dotfiles backup directory
# list of files to symlink in homedir
FILES="ackrc bashrc vimrc bash_aliases bash_functions tmux.conf pylintrc"

mkdir -p $OLDDIR
cd $DIR

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/dotfiles directory specified
# in $FILES
for file in $FILES; do
    if [ -f ~/.$file ] ; then
        mv ~/.$file $OLDDIR/
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $DIR/$file ~/.$file
done

if [ ! -f ~/.bash_untracked ] ; then
    cat << EOF > ~/.bash_untracked
# Use this file to store system specific aliases and functions
# It will not be versioned, and anything declared in here will
# override the other values
EOF
fi

echo "Installing any missing system dependencies - ^C to cancel"
if hash yum 2>/dev/null; then
    sudo yum install ctags python-virtualenvwrapper tmux git ack pylint nodejs wget
else
    sudo apt-get install exuberant-ctags virtualenvwrapper tmux git pyflakes nodejs wget
fi
sudo npm install -g jshint

# Enable bash completion of git subcommands
SCRIPT=https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
wget -O ~/.git-completion.bash $SCRIPT


echo "Installing VIM bundles"
vim +BundleInstall +qall

source ~/.bashrc

# Use vimdiff for git
git config --global alias.d difftool
git config --global alias.stat status
git config --global branch.master.rebase true
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global merge.tool vimdiff
