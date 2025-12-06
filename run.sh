#!/bin/bash

EXEC="$(dirname "$0")/bin/cppTemplate"

if [ ! -x "$EXEC" ]; then
    echo "Erro: executável não encontrado ou sem permissão:"
    echo "$EXEC"
    exit 1
fi

"$EXEC"

