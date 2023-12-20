#!/bin/bash

echo "Lista de dispositivos conectados:"
lsblk -nl | awk '{print NR, $1, $4}'

read -p "Digite o número do dispositivo que deseja usar como armazenamento: " escolha_numero

# Obtém o nome do dispositivo correspondente ao número escolhido
escolha=$(lsblk -nl | awk -v var="$escolha_numero" 'NR==var {print $1}')

if [ -b "/dev/$escolha" ]; then
    echo "Você escolheu /dev/$escolha como armazenamento."

    # Adicione aqui o código para usar o dispositivo selecionado, por exemplo, montá-lo.
    # Certifique-se de ter as permissões adequadas para montar o dispositivo.

    # Exemplo: Montando o dispositivo em /mnt
    sudo mount "/dev/$escolha" /mnt

    echo "O dispositivo /dev/$escolha foi montado em /mnt."
else
    echo "Dispositivo inválido. Certifique-se de inserir um número de dispositivo válido."
fi
