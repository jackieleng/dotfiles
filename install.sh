STARTDIR=$PWD

# symlinking
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
        if [ -h ~/.nvimrc ]; then
            rm ~/.nvimrc
            echo "Removed    ~/.nvimrc"
        fi
        echo "** Creating additional Neovim symlink"
        ln -s $PWD/$file ~/.nvimrc
        echo "Symlinked  $PWD/$file to ~/.nvimrc"
    fi
done

echo "cd back to $STARTDIR"
cd $STARTDIR

GTKCSS=~/.config/gtk-3.0/gtk.css
if [ -h "$GTKCSS" ]; then
    rm "$GTKCSS"
    echo "Removed    $GTKCSS"
fi
ln -s ${PWD}/gtk.css $GTKCSS
echo "Symlinked  ${PWD}/gtk.css to $GTKCSS"

# Download additional dependencies

if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    echo "Vundle not found, cloning..."
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -d ~/.config/base16-shell ]; then
    echo "Base16-shell not found, cloning..."
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

if [ ! -d ~/.fzf ]; then
    echo "FZF not found; installing..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

if [ ! -d ~/.git-prompt.sh ]; then
    echo "~/.git-prompt.sh not found; downloading..."
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi

# More Neovim symlinking
VIMDIR=~/.vim
NVIMDIR=~/.nvim
if ! [[ -d "$VIMDIR" && ! -L "$VIMDIR" ]]; then  # dir + symlink dir check
    echo "$VIMDIR doesn't exist yet, creating..."
    mkdir $VIMDIR
fi

if [ ! -L "$NVIMDIR" ]; then
    echo "Symlinking dir $VIMDIR to $NVIMDIR"
    ln -s $VIMDIR $NVIMDIR
fi

echo "Done!"

# TODO: install powerline fonts
