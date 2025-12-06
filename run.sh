#!/bin/bash

# ----------------------------
# CONFIGURAÇÕES DO SISTEMA
# ----------------------------

GTK="$HOME/.themes/Nashville96-Steam/gtk-3.0/whisker-menu2.css"
NOME_DO_ARQUIVO="whisker-menu2.css"
DEPENDENCY_FLAG="data/.dependencies_checked.txt"

# ----------------------------
# 1. INSTALAR DEPENDÊNCIAS (APENAS UMA VEZ)
# ----------------------------

if [ ! -f "$DEPENDENCY_FLAG" ]; then
    echo "[INFO] Dependências ainda não instaladas."
    echo "[INFO] Rodando Dependency_Installation.sh..."

    chmod +x release/dependencies.sh
    bash release/dependencies.sh
    sudo apt update

    # Criar flag de instalação
    touch "$DEPENDENCY_FLAG"
    echo "[INFO] Dependências instaladas. Este passo não será repetido."
    echo "----------------------------------------------"
else
    echo "[INFO] Dependências já instaladas. Pulando esta etapa."
fi

# ----------------------------
# 2. VERIFICAR ARQUIVO GTK
# ----------------------------

if [ -f "$GTK" ]; then
    echo "[INFO] Arquivo '$NOME_DO_ARQUIVO' encontrado."
    echo "[INFO] Iniciando aplicativo C#..."
    dotnet run --project script/MyTemplateUI.csproj

else
    echo "[ALERTA] O arquivo '$NOME_DO_ARQUIVO' NÃO existe."
    echo "[INFO] Criando arquivo agora..."

    mkdir -p "$(dirname "$GTK")"
    touch "$GTK"

    echo "[CRIADO] $GTK"
    echo "Rode o comando novamente."
fi
