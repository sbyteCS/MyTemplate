#!/bin/bash

echo "[INFO] Instalando dependências para rodar o aplicativo C#..."

# Verifica se dotnet está instalado
if ! command -v dotnet &> /dev/null; then
    echo "[INFO] .NET não encontrado. Instalando .NET SDK 9..."
    
    # Baixar repositório da Microsoft
    wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    sudo apt update
    sudo apt install -y dotnet-sdk-9.0
else
    echo "[INFO] .NET já instalado."
fi

# Instalar dotnet-script
if ! dotnet tool list -g | grep -q "dotnet-script"; then
    echo "[INFO] Instalando dotnet-script..."
    dotnet tool install -g dotnet-script
else
    echo "[INFO] dotnet-script já instalado."
fi

echo "[INFO] Tudo pronto! Pode rodar seu .csx normalmente."