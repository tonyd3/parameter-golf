#!/usr/bin/env bash
set -euo pipefail

# Baseline-scale 10-minute sweep on the PyTorch/CUDA path.
# This keeps architecture and optimizer settings fixed and varies only WARMUP_STEPS.

NPROC_PER_NODE="${NPROC_PER_NODE:-1}"
DATA_PATH="${DATA_PATH:-./data/datasets/fineweb10B_sp1024}"
TOKENIZER_PATH="${TOKENIZER_PATH:-./data/tokenizers/fineweb_1024_bpe.model}"
VOCAB_SIZE="${VOCAB_SIZE:-1024}"
MAX_WALLCLOCK_SECONDS="${MAX_WALLCLOCK_SECONDS:-600}"

for WARMUP in 0 20 40 100; do
  RUN_ID="warmup_${WARMUP}"
  echo "=== starting ${RUN_ID} ==="
  RUN_ID="${RUN_ID}" \
  DATA_PATH="${DATA_PATH}" \
  TOKENIZER_PATH="${TOKENIZER_PATH}" \
  VOCAB_SIZE="${VOCAB_SIZE}" \
  MAX_WALLCLOCK_SECONDS="${MAX_WALLCLOCK_SECONDS}" \
  TRAIN_LOG_EVERY=50 \
  VAL_LOSS_EVERY=0 \
  WARMUP_STEPS="${WARMUP}" \
  NUM_LAYERS=9 \
  MODEL_DIM=512 \
  NUM_HEADS=8 \
  NUM_KV_HEADS=4 \
  MLP_MULT=2 \
  TRAIN_BATCH_TOKENS=524288 \
  TRAIN_SEQ_LEN=1024 \
  LOGIT_SOFTCAP=15 \
  QK_GAIN_INIT=2.0 \
  TIED_EMBED_LR=0.0375 \
  MATRIX_LR=0.03 \
  SCALAR_LR=0.03 \
  MUON_BACKEND_STEPS=7 \
  POST_STEP_WEIGHT_CLIP=0.5 \
  torchrun --standalone --nproc_per_node="${NPROC_PER_NODE}" train_gpt.py
done
