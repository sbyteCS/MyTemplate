#!/bin/bash

APPLICATION_NAME="heavyrender_app"      # executável final
LIB_NAME="libheavyrender.so"            # biblioteca final

# Diretórios do projeto
SRC_CPP_DIR="heavyrender"
ENUMS_DIR="heavyrender/enums"
INTERFACES_DIR="heavyrender/interfaces"
OBJ_DIR="obj"
INCLUDE_DIR="include"

# Destinos finais
BIN_DIR="bin"
SCRIPT_DIR="script"
TARGET_SO="$SCRIPT_DIR/$LIB_NAME"
TARGET_EXE="$BIN_DIR/$APPLICATION_NAME"

# Log
LOG_DIR="log"
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
LOG_FILE="$LOG_DIR/compile_$TIMESTAMP.log"

mkdir -p "$OBJ_DIR" "$BIN_DIR" "$SCRIPT_DIR" "$LOG_DIR"

# Funções de log no formato solicitado
log() {
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOG_FILE"
}

sep() {
    echo "--------------------------------------------------------------------------------" | tee -a "$LOG_FILE"
}

# ======= INÍCIO DO LOG =======
log "============================= INICIANDO COMPILAÇÃO =============================="
sep
log "Projeto: $LIB_NAME"
log "Biblioteca final: $TARGET_SO"
log "Sistema operacional: $(uname -a)"
log "Diretório atual: $(pwd)"
log "Log salvo em: $LOG_FILE"
sep

COMPILATION_OK=true
COMPILED_COUNT=0
FAILED_COUNT=0

START_TIME=$(date +%s)

CPP_FILES=("$SRC_CPP_DIR"/*.cpp)

log "Arquivos detectados na pasta $SRC_CPP_DIR:"
for F in "${CPP_FILES[@]}"; do
    log " - $F"
done
sep

log "Iniciando compilação individual dos arquivos..."
sep

# Compilar arquivos .cpp
for FILE in "${CPP_FILES[@]}"; do
    BASENAME=$(basename "$FILE" .cpp)
    OBJ_FILE="$OBJ_DIR/$BASENAME.o"

    log "Compilando: $FILE"
    log "Saída: $OBJ_FILE"

    if g++ -fPIC \
        -I"$INCLUDE_DIR" \
        -I"$ENUMS_DIR" \
        -I"$INTERFACES_DIR" \
        -c "$FILE" -o "$OBJ_FILE" 2>>"$LOG_FILE"; then
        
        log "Status: SUCESSO"
        COMPILED_COUNT=$((COMPILED_COUNT + 1))
    else
        log "Status: FALHA"
        FAILED_COUNT=$((FAILED_COUNT + 1))
        COMPILATION_OK=false
    fi

    sep
done

log "Resumo da compilação:"
log " - Arquivos compilados com sucesso: $COMPILED_COUNT"
log " - Arquivos com erro: $FAILED_COUNT"
sep

# Linkar biblioteca .so
if $COMPILATION_OK; then
    log "Iniciando linkagem final para gerar biblioteca..."
    log "Saída prevista: $TARGET_SO"
    sep

    if g++ -shared "$OBJ_DIR"/*.o -o "$TARGET_SO" 2>>"$LOG_FILE"; then
        log "Linkagem final concluída."
        log "Biblioteca gerada com sucesso em:"
        log " -> $TARGET_SO"
    else
        log "ERRO durante a linkagem da biblioteca."
        COMPILATION_OK=false
    fi

else
    log "Erros encontrados na compilação. Linkagem cancelada."
fi

sep

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))

log "Tempo total de execução: ${ELAPSED}s"
log "Encerrado em: $(date)"
sep

log "============================= FIM DA COMPILAÇÃO ================================"
echo
echo "Build concluído"
echo "Biblioteca gerada: $TARGET_SO"
echo "Executável (se habilitado depois): $TARGET_EXE"
echo "Log salvo em: $LOG_FILE"