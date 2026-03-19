#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../../.." && pwd)"
cd "$SCRIPT_DIR"

RUN_ID=loop01_exp08_batch393216 \
DATA_PATH="$REPO_ROOT/data/datasets/fineweb10B_sp1024" \
TOKENIZER_PATH="$REPO_ROOT/data/tokenizers/fineweb_1024_bpe.model" \
VOCAB_SIZE=1024 \
MAX_WALLCLOCK_SECONDS=600 \
VAL_LOSS_EVERY=0 \
TRAIN_LOG_EVERY=50 \
WARMUP_STEPS=20 \
ATTN_BACKEND=flash \
MIN_LR_SCALE=0.1 \
TRAIN_BATCH_TOKENS=393216 \
TRAIN_SEQ_LEN=1024 \
TRAIN_SEQ_LEN_START=512 \
SEQ_LEN_WARMUP_STEPS=150 \
NUM_LAYERS=9 \
MODEL_DIM=512 \
NUM_HEADS=8 \
NUM_KV_HEADS=4 \
MLP_MULT=2 \
TIE_EMBEDDINGS=1 \
torchrun --standalone --nproc_per_node=1 "$SCRIPT_DIR/train_gpt.py"
