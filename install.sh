# The install script for the environment.

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
git submodule init
git submodule update
cp -r $DIR/vim ~/.vim

if [ ! -f ~/.bash_untracked ] ; then
    cat << EOF > ~/.bash_untracked
# Use this file to store system specific aliases and functions
# It will not be versioned, and anything declared in here will
# override the other values
EOF
fi

echo "Installing any missing system dependencies - ^C to cancel"
if hash yum 2>/dev/null; then
    sudo yum install vim gcc ctags python-virtualenvwrapper tmux git ack pylint nodejs wget npm cmake bash_completion
elif [ "$(uname)" == "Darwin" ]; then
    #brew install vim gcc ctags python-virtualenvwrapper tmux git ack pylint nodejs wget npm cmake
    echo "MAC"
else
    sudo apt-get install vim gcc exuberant-ctags virtualenvwrapper tmux git pyflakes nodejs wget npm cmake
fi
#sudo npm install -g jshint
#udo pip install jedi

# Enable bash completion of git subcommands
script=https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
wget -O ~/.git-completion.bash $script

echo "Installing VIM bundles.."
vim +BundleInstall +qall
echo

echo "Compiling YouCompleteMe..."
cd ~/.vim/bundle/YouCompleteMe
./install.sh
cd -

source ~/.bashrc

# If there is no gitconfig file, copy, but don't link the one from the repo
# we do it this way because we're modifying the file below locally, and don't
# want to have the changes go into git
if [ ! -f ~/.gitconfig ]; then
    echo "Creating gitconfig file"
    cp gitconfig ~/.gitconfig
fi

USER=`whoami`
GITCONFIG="/home/$USER/.gitconfig"
# If the user section of the gitconfig file is not setup, take care of that
# by promting the user for the info
if ! grep -q 'user' ~/.gitconfig; then
    echo "Configuring git user settings..."

    read -p "What is your name? " name
    if [ ! -z "$name" ]; then
        git config --global user.name "$name"
    fi

    read -p "What is your email? " email
    if [ ! -z "$email" ]; then
        git config --global user.email $email
    fi
fi

echo
echo "Setup Complete!"
