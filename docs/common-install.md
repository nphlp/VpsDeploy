# Common Install

## Ubuntu et SSH

-   [ ] Installer Ubuntu sur le VPS depuis le panneau Hostinger

-   [ ] Configurer la connexion SSH entre le VPS et la machine locale

-   [ ] Se connecter en SSH au VPS

```bash
ssh root@my-vps-ip-address
```

## Update & Upgrade

```bash
apt update && apt upgrade -y
```

Lors de la première installation, si une fenêtre rose "Configuring openssh-server" apparaît : sélectionner la première option "install the package maintainer's version".

Lors des mises à jour suivantes : sélectionner la deuxième option "keep the local version currently installed".

## Install Tree

```bash
apt install tree -y
tree -L 2 ../
```

## Install Make

```bash
sudo apt install make -y
```

## Install Lazydocker

```bash
# Installer Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
# Lien symbolique pour un accès global
ln -s /root/.local/bin/lazydocker /usr/local/bin/lazydocker
```
