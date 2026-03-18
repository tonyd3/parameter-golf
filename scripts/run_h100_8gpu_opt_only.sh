#!/usr/bin/env bash
set -euo pipefail

# Baseline-scale 8xH100 run with low-overhead trainer settings.
# This keeps the published 9x512 KV4 layout and applies the safer
# training-only improvements we found useful during local iteration.

NPROC_PER_NODE="${NPROC_PER_NODE:-8}"
NCCL_IB_DISABLE="${NCCL_IB_DISABLE:-1}"
RUN_ID="${RUN_ID:-exp39_8gpu_opt_only}"
DATA_PATH="${DATA_PATH:-./data/datasets/fineweb10B_sp1024}"
TOKENIZER_PATH="${TOKENIZER_PATH:-./data/tokenizers/fineweb_1024_bpe.model}"
VOCAB_SIZE="${VOCAB_SIZE:-1024}"
MAX_WALLCLOCK_SECONDS="${MAX_WALLCLOCK_SECONDS:-600}"

export NCCL_IB_DISABLE

RUN_ID="${RUN_ID}" \
DATA_PATH="${DATA_PATH}" \
TOKENIZER_PATH="${TOKENIZER_PATH}" \
VOCAB_SIZE="${VOCAB_SIZE}" \
MAX_WALLCLOCK_SECONDS="${MAX_WALLCLOCK_SECONDS}" \
VAL_LOSS_EVERY=0 \
TRAIN_LOG_EVERY=50 \
WARMUP_STEPS="${WARMUP_STEPS:-0}" \
NUM_LAYERS=9 \
MODEL_DIM=512 \
NUM_HEADS=8 \
NUM_KV_HEADS=4 \
MLP_MULT=2 \
TRAIN_BATCH_TOKENS=524288 \
TRAIN_SEQ_LEN=1024 \
TIE_EMBEDDINGS=1 \
TIED_EMBED_LR=0.0375 \
MATRIX_LR=0.03 \
SCALAR_LR=0.03 \
LOGIT_SOFTCAP=15 \
QK_GAIN_INIT=2.0 \
MUON_BACKEND_STEPS=7 \
POST_STEP_WEIGHT_CLIP=0.5 \
torchrun --standalone --nproc_per_node="${NPROC_PER_NODE}" train_gpt.py
