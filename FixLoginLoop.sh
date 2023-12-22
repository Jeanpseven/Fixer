#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
    echo "Execute o script como root (use sudo)."
    exit 1
fi

# Verifica o ambiente de desktop (substitua 'lightdm' se estiver usando um ambiente diferente)
desktop_manager="lightdm"

# Backup do arquivo de configuração
config_file="/etc/$desktop_manager/$desktop_manager.conf"
backup_file="/etc/$desktop_manager/$desktop_manager.conf.bak"

if [ -e "$config_file" ]; then
    echo "Fazendo backup do arquivo de configuração..."
    mv "$config_file" "$backup_file"
fi

# Remoção do arquivo de configuração do usuário (substitua 'kali' pelo nome do seu usuário)
user_config="/home/kali/.config/$desktop_manager/$desktop_manager.conf"

if [ -e "$user_config" ]; then
    echo "Removendo o arquivo de configuração do usuário..."
    rm "$user_config"
fi

# Reparação das permissões
echo "Reparando permissões..."
chown -R root:root /etc/$desktop_manager
chmod -R 755 /etc/$desktop_manager

echo "Concluído. Reinicie o sistema para aplicar as alterações."
