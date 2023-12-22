#!/bin/bash

# Função para montar o dispositivo escolhido
montar_dispositivo() {
    echo "Montando o dispositivo escolhido..."
    sudo mount "/dev/$escolha" /mnt
    echo "O dispositivo /dev/$escolha foi montado em /mnt."
}

# Função para desmontar o dispositivo escolhido e remover a entrada do /etc/fstab
desmontar_dispositivo() {
    echo "Desmontando o dispositivo escolhido..."
    sudo umount "/mnt"
    echo "Removendo a entrada do /etc/fstab..."
    sudo sed -i "/\/dev\/$escolha/d" /etc/fstab
    echo "Desmontagem e remoção de entrada concluídas."
}

# Função para remover o bind associado à tecla Scroll Lock
remover_bind_scroll_lock() {
    echo "Removendo o bind associado à tecla Scroll Lock..."
    xmodmap -e "keycode 78 = Scroll_Lock = Scroll_Lock"
    xmodmap -e "remove mod3 = Scroll_Lock"
    echo "Bind da tecla Scroll Lock removido."
}

# Lista de dispositivos conectados
echo "Lista de dispositivos conectados:"
lsblk -nl | awk '{print NR, $1, $4}'

# Solicita ao usuário escolher um dispositivo
read -p "Digite o número do dispositivo que deseja usar como armazenamento: " escolha_numero

# Obtém o nome do dispositivo correspondente ao número escolhido
escolha=$(lsblk -nl | awk -v var="$escolha_numero" 'NR==var {print $1}')

if [ -b "/dev/$escolha" ]; then
    echo "Você escolheu /dev/$escolha como armazenamento."

    # Verifica se o dispositivo já está montado
    if mountpoint -q /mnt; then
        echo "Um dispositivo já está montado em /mnt. Deseja desmontá-lo e remover a entrada do /etc/fstab? (S/n)"
        read -n 1 resposta

        if [[ $resposta =~ ^[Ss]$ ]]; then
            desmontar_dispositivo
        else
            echo "Operação cancelada. O dispositivo permanecerá montado."
            exit 0
        fi
    fi

    # Monta o dispositivo
    montar_dispositivo

    # Adiciona a entrada ao /etc/fstab para montar automaticamente na inicialização
    echo "/dev/$escolha   /mnt   auto   defaults   0   0" | sudo tee -a /etc/fstab > /dev/null

    # Remove o bind associado à tecla Scroll Lock
    remover_bind_scroll_lock

    echo "O dispositivo /dev/$escolha foi montado em /mnt, configurado para montar automaticamente na inicialização, e o bind da tecla Scroll Lock foi removido."
else
    echo "Dispositivo inválido. Certifique-se de inserir um número de dispositivo válido."
fi
