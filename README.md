# My Linux dotfiles

## Installations

### Arch

#### First boot

```shell
pacman -Sy wget

wget https://raw.githubusercontent.com/Harkame/dotfilesLinux/master/install/arch/install.sh

chmod +x ./install.sh

./install.sh
```

#### First log

```shell
sudo pacman -Sy git

git clone https://github.com/Harkame/dotfilesLinux.git

cd dotfilesLinux/install/arch

chmod +x ./end_install.sh ./export.sh

./end_install.sh
```