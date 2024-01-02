#!/bin/bash

# Certifique-se de ter backups antes de executar este script!

# Novo disco (substitua /dev/sdb pelo seu disco)
novo_disco="/dev/sdb"

# 1. Preparação do disco
sudo parted $novo_disco mklabel gpt
sudo parted $novo_disco mkpart primary ext4 1MiB 100%
sudo mkfs.ext4 ${novo_disco}1

# 2. Montar nova partição
sudo mount ${novo_disco}1 /mnt

# 3. Copiar dados para a nova partição
sudo rsync -a / /mnt

# 4. Atualizar /etc/fstab
echo "${novo_disco}1   /   ext4   defaults   0   1" | sudo tee -a /etc/fstab > /dev/null

# 5. Atualizar Configurações do Grub (se necessário)
# (Descomente e ajuste conforme a sua configuração)
# sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="root=UUID=<novo_uuid> ro quiet splash"/' /etc/default/grub
# sudo update-grub

# 6. Reiniciar
sudo reboot