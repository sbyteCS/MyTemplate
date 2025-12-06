#!/bin/bash

# Local onde está a biblioteca
LIB_DIR="$(dirname "$0")"

export LD_LIBRARY_PATH="$LIB_DIR:$LD_LIBRARY_PATH"

dotnet-script "$LIB_DIR/Program.csx"