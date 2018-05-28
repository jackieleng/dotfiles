STARTDIR=$PWD

# Symlinking dotfiles in home dir
echo "cd into ./home"
cd home
FILES=$(ls -a)
FILES2=''

for file in $FILES; do
    if [ -f "$file" ]; then  # check if regular file, i.e., exclude '.' and '..'
        FILES2="$FILES2 $file"
    fi
done

echo "Will symlink the following files under $HOME:"
echo $FILES2; echo

for file in $FILES2; do
    if [ -h ~/"$file" ]; then  # only symlinks
        rm ~/"$file"
        echo "Removed    ~/"$file""
    fi

    ln -s $PWD/$file ~/$file
    echo "Symlinked  $PWD/$file to ~/$file"

    # Neovim specific symlink
    if [ "$file" == .vimrc ]; then
        # Symlink/create dirs
        XDG_CONFIG_HOME=~/.config
        VIMDIR=~/.vim
        NVIMDIR="$XDG_CONFIG_HOME/nvim"
        if ! [[ -d "$VIMDIR" && ! -L "$VIMDIR" ]]; then  # dir + symlink dir check
            echo "$VIMDIR doesn't exist yet, creating..."
            mkdir $VIMDIR
        fi

        if ! [[ -d "$XDG_CONFIG_HOME" ]]; then
            echo "$XDG_CONFIG_HOME doesn't exist yet, creating..."
            mkdir -p $XDG_CONFIG_HOME
        fi

        if [ ! -L "$NVIMDIR" ]; then
            echo "Symlinking dir $VIMDIR to $NVIMDIR"
            ln -s $VIMDIR $NVIMDIR
        fi

        # Symlink init.vim
        if [ -h "$NVIMDIR/init.vim" ]; then
            rm "$NVIMDIR/init.vim"
            echo "Removed    $NVIMDIR/init.vim"
        fi
        echo "** Creating additional Neovim symlink"
        ln -s $PWD/$file $NVIMDIR/init.vim
        echo "Symlinked  $PWD/$file to $NVIMDIR/init.vim"
    fi
done

echo "cd back to $STARTDIR"
cd $STARTDIR

# Download additional dependencies

if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    echo "Vundle not found, cloning..."
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -d ~/.fzf ]; then
    echo "FZF not found; installing..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

if [ ! -e ~/.git-prompt.sh ]; then
    echo "~/.git-prompt.sh not found; downloading..."
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
fi

echo "Done!"

# TODO: install powerline fonts
