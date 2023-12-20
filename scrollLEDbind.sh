#!/bin/bash

# Nome do script
script_name="toggle_led.sh"

# Conteúdo do script
script_content="#!/bin/bash\n\nif xset q | grep 'LED mask' | grep -q '00000002'; then\n    xset led named 'Scroll Lock'\nelse\n    xset -led named 'Scroll Lock'\nfi"

# Caminho para o diretório do usuário
user_dir="$HOME"

# Caminho completo para o script
script_path="$user_dir/$script_name"

# Criar o script
echo -e "$script_content" > "$script_path"
chmod +x "$script_path"

# Criar o arquivo de configuração do xbindkeys se não existir
xbindkeys_config="$user_dir/.xbindkeysrc"
if [ ! -e "$xbindkeys_config" ]; then
    touch "$xbindkeys_config"
fi

# Adicionar configuração ao arquivo xbindkeys
echo -e "\"$script_path\"\n    Mod2 + Scroll_Lock" >> "$xbindkeys_config"

# Reiniciar o xbindkeys
killall xbindkeys
xbindkeys

echo "Configuração concluída. O LED do teclado será alternado ao pressionar Scroll Lock."
