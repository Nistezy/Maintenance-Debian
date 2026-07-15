#!/bin/bash

# ==========================================================
# TOOLKIT DE MANUTENÇÃO - DEBIAN 13 (TRIXIE)
# Autor: Mauricio
# Descrição:
# Script interativo para manutenção, limpeza, diagnóstico
# ==========================================================

# =========================
# CONFIGURAÇÕES INICIAIS
# =========================

set -euo pipefail

LOG="/var/log/toolkit_manutencao.log"

# Redireciona saída para log + terminal
exec > >(tee -a "$LOG") 2>&1

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

# =========================
# VALIDAÇÃO DE ROOT
# =========================
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[ERRO] Execute como root!${RESET}"
    exit 1
fi

# =========================
# FUNÇÕES
# =========================

# Atualização do sistema
update_system() {
    echo -e "${GREEN}[+] Atualizando sistema...${RESET}"

    dpkg --configure -a
    apt-get --fix-broken install -y
    apt-get update
    apt-get upgrade -y

    echo -e "${GREEN}[OK] Sistema atualizado!${RESET}"
}

# Limpeza do sistema
clean_system() {
    echo -e "${BLUE}[+] Limpando sistema...${RESET}"

    apt-get autoremove --purge -y
    apt-get clean
    apt-get autoclean

    rm -rf ~/.cache/thumbnails/*
    rm -rf ~/.cache/*

    find /var/tmp -type f -atime +3 -delete

    echo -e "${GREEN}[OK] Limpeza concluída!${RESET}"
}

# Limpeza de logs (segura)
clean_logs() {
    echo -e "${YELLOW}[+] Limpando logs do systemd...${RESET}"

    journalctl --vacuum-time=7d
    journalctl --vacuum-size=500M

    echo -e "${GREEN}[OK] Logs limpos!${RESET}"
}

# Diagnóstico do sistema
system_diagnostics() {
    echo -e "${BLUE}[+] Diagnóstico do sistema...${RESET}"

    echo "-----------------------------"
    echo "Uso de disco:"
    df -h
    echo "-----------------------------"

    echo "Serviços com falha:"
    systemctl --failed || true
    echo "-----------------------------"

    echo "Memória:"
    free -h
    echo "-----------------------------"

    echo "Carga do sistema:"
    uptime
    echo "-----------------------------"

    echo -e "${GREEN}[OK] Diagnóstico finalizado!${RESET}"
}

# Verificação de integridade de pacotes
check_integrity() {
    echo -e "${YELLOW}[+] Verificando integridade de pacotes...${RESET}"

    if command -v debsums &> /dev/null; then
        debsums -s
    else
        echo "debsums não instalado."
    fi

    echo -e "${GREEN}[OK] Verificação concluída!${RESET}"
}

# Limpeza de histórico
clean_history() {
    echo -e "${YELLOW}[+] Limpando histórico...${RESET}"

    history -c
    rm -f ~/.bash_history

    echo -e "${GREEN}[OK] Histórico limpo!${RESET}"
}

# Execução completa
full_maintenance() {
    echo -e "${GREEN}[+] Executando manutenção completa...${RESET}"

    update_system
    clean_system
    clean_logs
    clean_history

    echo -e "${GREEN}[OK] Manutenção completa finalizada!${RESET}"
}

# =========================
# MENU INTERATIVO
# =========================

menu() {
    while true; do
        echo -e "\n${BLUE}========= TOOLKIT DE MANUTENÇÃO =========${RESET}"
        echo "1) Atualizar sistema"
        echo "2) Limpar sistema"
        echo "3) Limpar logs"
        echo "4) Diagnóstico do sistema"
        echo "5) Verificar integridade"
        echo "6) Limpar histórico"
        echo "7) Manutenção completa"
        echo "0) Sair"
        echo "========================================="
        read -p "Escolha uma opção: " opcao

        case $opcao in
            1) update_system ;;
            2) clean_system ;;
            3) clean_logs ;;
            4) system_diagnostics ;;
            5) check_integrity ;;
            6) clean_history ;;
            7) full_maintenance ;;
            0) echo "Saindo..."; exit 0 ;;
            *) echo -e "${RED}Opção inválida!${RESET}" ;;
        esac
    done
}

# =========================
# INICIALIZAÇÃO
# =========================
menu
