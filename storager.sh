#!/bin/bash

echo "Lista de dispositivos conectados:"
lsblk

read -p "Digite o número do dispositivo que deseja usar como armazenamento: " escolha_numero

# Obtém o nome do dispositivo correspondente ao número escolhido
escolha=$(lsblk -nl | awk -v var="$escolha_numero" 'NR==var {print $1}')

if [ -b "/dev/$escolha" ]; then
    echo "Você escolheu /dev/$escolha como armazenamento."

    # Adiciona a entrada ao /etc/fstab
    echo "/dev/$escolha   /caminho/de/montagem   tipo_de_sistema_de_arquivos   defaults   0   2" | sudo tee -a /etc/fstab > /dev/null

    # Cria o diretório de montagem, se não existir
    sudo mkdir -p /caminho/de/montagem

    # Monta o dispositivo
    sudo mount -a

    echo "O dispositivo /dev/$escolha será montado automaticamente na inicialização."
else
    echo "Dispositivo inválido. Certifique-se de inserir um número de dispositivo válido."
fi
