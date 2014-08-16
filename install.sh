mv ~/.vimrc ~/.vimrc.backup
rm -rf ~/.vim.backup
mv ~/.vim ~/.vim.backup
cp .vimrc ~/.vimrc
cp -r .vim/ ~/.vim/
echo 'Installation Completed.'

