#!/bin/bash

APPLICATION_NAME="libheavyrender.so"

# Diretórios
SRC_CPP_DIR="heavyrender"
ENUMS_DIR="heavyrender/enums"
INTERFACES_DIR="heavyrender/interfaces"
OBJ_DIR="obj"
SRC_CS_DIR="src"
INCLUDE_DIR="include"

# Saída final (somente em script/lib)
TARGET_SO="$LIB_DIR/$APPLICATION_NAME"

# Log
LOG_DIR="log"
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
LOG_FILE="$LOG_DIR/compile_$TIMESTAMP.log"

mkdir -p "$OBJ_DIR" "$LIB_DIR" "$LOG_DIR"

log() {
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOG_FILE"
}

sep() {
    echo "--------------------------------------------------------------------------------" | tee -a "$LOG_FILE"
}

log "============================= INICIANDO COMPILAÇÃO =============================="
sep
log "Projeto: $APPLICATION_NAME"
log "Início da execução: $(date)"
log "Sistema operacional: $(uname -a)"
log "Diretório atual: $(pwd)"
log "Log salvo em: $LOG_FILE"
sep

COMPILATION_OK=true
COMPILED_COUNT=0
FAILED_COUNT=0

START_TIME=$(date +%s)

CPP_FILES=("$SRC_DIR"/*.cpp)
if [ ! -e "${CPP_FILES[0]}" ]; then
    log "Nenhum arquivo .cpp encontrado na pasta $SRC_DIR"
    exit 1
fi

log "Arquivos detectados na pasta $SRC_DIR:"
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

    if g++ -fPIC -I"$INCLUDE_DIR" -I"$ENUMS_DIR" -I"$INTERFACES_DIR" -c "$FILE" -o "$OBJ_FILE" 2>>"$LOG_FILE"; then
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
        log "Erro durante a linkagem da biblioteca."
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
echo "Compilação finalizada. Consulte o log detalhado em:"
echo " -> $LOG_FILE"