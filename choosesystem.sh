#!/bin/bash

# Certifique-se de ter backups antes de executar este script!

echo "Lista de dispositivos conectados:"
lsblk -nl | awk '{print NR, $1, $4}'

read -p "Digite o número do dispositivo que deseja usar como sistema padrão Linux: " escolha_numero

# Obtém o nome do dispositivo correspondente ao número escolhido
escolha=$(lsblk -nl | awk -v var="$escolha_numero" 'NR==var {print $1}')

if [ -b "/dev/$escolha" ]; then
    echo "Você escolheu /dev/$escolha como sistema padrão Linux."

    read -p "Digite o tamanho desejado para a partição (exemplo: 30G): " tamanho_particao

    # 1. Montar nova partição
    sudo parted "/dev/$escolha" mklabel gpt
    sudo parted "/dev/$escolha" mkpart primary ext4 1MiB $tamanho_particao
    sudo mkfs.ext4 "/dev/${escolha}1"

    # 2. Montar a nova partição
    sudo mount "/dev/${escolha}1" /mnt

    # 3. Copiar dados para a nova partição
    sudo rsync -a / /mnt

    # 4. Atualizar /etc/fstab
    echo "/dev/${escolha}1   /   ext4   defaults   0   1" | sudo tee -a /etc/fstab > /dev/null

    echo "As configurações foram aplicadas com sucesso. O dispositivo /dev/$escolha foi configurado como sistema padrão Linux."
else
    echo "Dispositivo inválido. Certifique-se de inserir um número de dispositivo válido."
fi