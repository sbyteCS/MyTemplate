#!/bin/bash

echo "[INFO] Instalando dependências para rodar o aplicativo C#..."

# -------------------------------------------------------------------
# 1. Verifica se o .NET está instalado
# -------------------------------------------------------------------
if ! command -v dotnet &> /dev/null; then
    echo "[INFO] .NET não encontrado. Instalando .NET SDK 9..."

    wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    sudo apt update
    sudo apt install -y dotnet-sdk-9.0
else
    echo "[INFO] .NET já instalado."
fi

# -------------------------------------------------------------------
# 2. Instalar dependências necessárias para rodar Eto.Forms (GTK3)
# -------------------------------------------------------------------
echo "[INFO] Instalando dependências do GTK3 para Eto.Forms..."

sudo apt update
sudo apt install -y \
    libgtk-3-0 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libatk1.0-0 \
    libcairo2 \
    libatk-bridge2.0-0 \
    libx11-6 \
    libxcomposite1 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxcursor1 \
    libxdamage1 \
    libxext6

echo "[INFO] Dependências GTK para Eto.Forms instaladas com sucesso!"

# -------------------------------------------------------------------
# 3. Mensagem final
# -------------------------------------------------------------------
echo "[INFO] Tudo pronto! Seu aplicativo C# com Eto.Forms agora pode rodar normalmente."