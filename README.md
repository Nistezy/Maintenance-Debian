# 🧰 Linux Maintenance Toolkit

Toolkit avançado em Bash para manutenção, limpeza e diagnóstico de sistemas Linux (focado em Debian 12/13). Projetado com boas práticas de administração, segurança e observabilidade.

---

## 🚀 Funcionalidades

* 🔄 Atualização segura do sistema (`apt-get`)
* 🧹 Limpeza de cache, pacotes obsoletos e temporários
* 📜 Gerenciamento de logs com `journalctl`
* 🔍 Diagnóstico completo do sistema:

  * Uso de disco
  * Memória
  * Carga
  * Serviços com falha
* 🛡️ Verificação de integridade (`debsums`)
* 🧠 Limpeza de histórico
* ⚙️ Execução completa automatizada (`--full`)
* 📋 Logging persistente para auditoria
* 🎨 Interface interativa via menu

---

## 📦 Requisitos

* Debian 12/13 ou derivados
* Permissões de root
* (Opcional) `debsums`

Instalar dependência opcional:

```bash
sudo apt-get install debsums -y
```

---

## ▶️ Como usar

### 🔹 Modo interativo

```bash
chmod +x toolkit.sh
sudo ./toolkit.sh
```

### 🔹 Execução completa (automática)

```bash
sudo ./toolkit.sh --full
```

---

## 📊 Logs

Todas as ações são registradas em:

```
/var/log/toolkit_manutencao.log
```

---

## 🔒 Segurança

* Execução restrita a root
* Uso de `set -euo pipefail`
* Evita remoção manual agressiva de logs
* Operações seguras e controladas

---

## 🧩 Estrutura do Projeto

```
.
├── toolkit.sh
└── README.md
```

---

## 💡 Casos de Uso

* Administração de sistemas Linux
* Laboratórios de cibersegurança (Blue Team / SOC)
* Automação de manutenção
* Estudos de observabilidade
* Ambientes pessoais e servidores

---

## 📜 Licença

Este projeto é open-source e pode ser utilizado livremente para fins educacionais e profissionais.
