#!/bin/bash

# Define o fuso horário para São Paulo
sudo timedatectl set-timezone America/Sao_Paulo

# Exibe o novo fuso horário
echo "Fuso horário alterado para São Paulo."
sudo date -s "2 hours 3 minutes"
