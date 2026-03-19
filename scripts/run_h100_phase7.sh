#!/usr/bin/env bash
set -euo pipefail

# Phase 7 single-A40 replication runner.
# This script only launches experiments whose local knobs map cleanly onto train_gpt.py.
# For MLX-only or non-comparable experiments, it exits with a concrete reason instead of guessing.

NPROC_PER_NODE="${NPROC_PER_NODE:-1}"

COMMON_ENV=(
  "DATA_PATH=${DATA_PATH:-./data/datasets/fineweb10B_sp1024}"
  "TOKENIZER_PATH=${TOKENIZER_PATH:-./data/tokenizers/fineweb_1024_bpe.model}"
  "VOCAB_SIZE=${VOCAB_SIZE:-1024}"
  "MAX_WALLCLOCK_SECONDS=${MAX_WALLCLOCK_SECONDS:-600}"
  "VAL_LOSS_EVERY=${VAL_LOSS_EVERY:-0}"
  "TRAIN_LOG_EVERY=${TRAIN_LOG_EVERY:-50}"
  "WARMUP_STEPS=${WARMUP_STEPS:-20}"
  "ATTN_BACKEND=${ATTN_BACKEND:-flash}"
  "TRAIN_BATCH_TOKENS=${TRAIN_BATCH_TOKENS:-524288}"
  "TRAIN_SEQ_LEN=${TRAIN_SEQ_LEN:-1024}"
  "NUM_LAYERS=${NUM_LAYERS:-9}"
  "MODEL_DIM=${MODEL_DIM:-512}"
  "NUM_HEADS=${NUM_HEADS:-8}"
  "NUM_KV_HEADS=${NUM_KV_HEADS:-4}"
  "MLP_MULT=${MLP_MULT:-2}"
  "TIE_EMBEDDINGS=${TIE_EMBEDDINGS:-1}"
)

print_usage() {
  cat <<'EOF'
Usage:
  scripts/run_h100_phase7.sh list
  scripts/run_h100_phase7.sh <phase7_id>

Examples:
  scripts/run_h100_phase7.sh 44
  scripts/run_h100_phase7.sh 53
  NPROC_PER_NODE=1 scripts/run_h100_phase7.sh 78

This runner covers the Phase 7 experiments that are directly portable from the local MLX notes to train_gpt.py on the current A40 box.
EOF
}

print_list() {
  cat <<'EOF'
Directly launchable:
  44  exp01  NUM_KV_HEADS=1
  51  exp08  low/high LR sweep
  53  exp10  QK gain sweep
  54  exp11  logit softcap sweep
  55  exp12  sequence length / RoPE sweep
  56  exp13  Muon hyperparameter sweep
  60  exp17  post-step weight clip sweep
  61  exp18  untied head only
  64  exp21  seq512 + clip0.5
  65  exp22  seq512 + clip0.5 + untied
  69  exp26  bigram hash on top of seq512 + clip0.5
  78  exp35  bigram hash + seq512 + clip0.5 + untied

Blocked or ambiguous:
  45  exp02  remote baseline already uses MLP_MULT=2
  46  exp03  local delta does not map cleanly to 9-layer A40 baseline
  47  exp04  local delta does not map cleanly to 512-dim A40 baseline
  48  exp05  iso-budget redesign required
  49  exp06  longer-run experiment is not comparable to the 10-minute A40 regime
  50  exp07  local batch-token values do not map cleanly to the A40 baseline
  52  exp09  local warmdown setup depended on disabling the wallclock cap
  57  exp14  NUM_UNIQUE_BLOCKS not implemented in train_gpt.py
  58  exp15  alternating block MLP control not implemented in train_gpt.py
  59  exp16  LOW_RANK_MLP_RANK not implemented in train_gpt.py
  62  exp19  sp512/sp2048 tokenizer assets are not present here
  63  exp20  EVAL_EXTRA_PASSES not implemented in train_gpt.py
  66  exp23  longer-run experiment is not comparable to the 10-minute A40 regime
  67  exp24  NUM_UNIQUE_BLOCKS not implemented in train_gpt.py
  68  exp25  MTP_TOKENS not implemented in train_gpt.py
  70  exp27  USE_VALUE_EMBED not implemented in train_gpt.py
  71  exp28  PARTIAL_KEY_OFFSET_DIMS not implemented in train_gpt.py
  72  exp29  USE_SECOND_INPUT_EMBED not implemented in train_gpt.py
  73  exp30  USE_TOKEN_SMEAR_FORWARD not implemented in train_gpt.py
  74  exp31  planned only, no finished local source run
  75  exp32  planned only, no finished local source run
  76  exp33  planned only, no finished local source run
  77  exp34  planned only, no finished local source run
  79  exp36  longer-run experiment is not comparable to the 10-minute A40 regime
  80  exp37  MLX warmup semantics do not match train_gpt.py
EOF
}

run_one() {
  local run_id="$1"
  shift
  local -a extra_env=("$@")

  echo "=== starting ${run_id} ==="
  echo "Exact command:"
  printf '```bash\n'
  printf 'RUN_ID=%s \\\n' "${run_id}"
  local kv
  for kv in "${COMMON_ENV[@]}"; do
    printf '%s \\\n' "${kv}"
  done
  for kv in "${extra_env[@]}"; do
    printf '%s \\\n' "${kv}"
  done
  printf 'torchrun --standalone --nproc_per_node=%s train_gpt.py\n' "${NPROC_PER_NODE}"
  printf '```\n'

  env "RUN_ID=${run_id}" "${COMMON_ENV[@]}" "${extra_env[@]}" \
    torchrun --standalone --nproc_per_node="${NPROC_PER_NODE}" train_gpt.py
}

blocked() {
  local why="$1"
  printf 'Phase 7 experiment %s is blocked: %s\n' "${TARGET_ID}" "${why}" >&2
  exit 1
}

if [[ $# -ne 1 ]]; then
  print_usage
  exit 1
fi

TARGET_ID="$1"

case "${TARGET_ID}" in
  list|-l|--list)
    print_list
    ;;
  44)
    run_one "exp44_h100_kv1" "NUM_KV_HEADS=1"
    ;;
  45)
    blocked "remote baseline already uses MLP_MULT=2, so the local exp02 delta is a no-op"
    ;;
  46)
    blocked "the local exp03 depth change does not map cleanly onto the 9-layer A40 baseline"
    ;;
  47)
    blocked "the local exp04 width change does not map cleanly onto the 512-dim A40 baseline"
    ;;
  48)
    blocked "the local exp05 iso-budget comparison needs a fresh remote redesign, not a direct replay"
    ;;
  49)
    blocked "the local exp06 longer-run result is not comparable to a 10-minute single-A40 run"
    ;;
  50)
    blocked "the local exp07 batch-token values do not map cleanly onto the A40 baseline token budget"
    ;;
  51)
    run_one "exp51a_h100_lr_low" "TIED_EMBED_LR=0.0375" "MATRIX_LR=0.03" "SCALAR_LR=0.03"
    run_one "exp51b_h100_lr_high" "TIED_EMBED_LR=0.0625" "MATRIX_LR=0.05" "SCALAR_LR=0.05"
    ;;
  52)
    blocked "the local exp09 warmdown test depended on MAX_WALLCLOCK_SECONDS=0, which is not comparable here"
    ;;
  53)
    run_one "exp53a_h100_qk1" "QK_GAIN_INIT=1.0"
    run_one "exp53b_h100_qk2" "QK_GAIN_INIT=2.0"
    ;;
  54)
    run_one "exp54a_h100_softcap15" "LOGIT_SOFTCAP=15"
    run_one "exp54b_h100_softcap50" "LOGIT_SOFTCAP=50"
    ;;
  55)
    run_one "exp55a_h100_seq512_rope10k" "TRAIN_SEQ_LEN=512" "ROPE_BASE=10000"
    run_one "exp55b_h100_seq1024_rope50k" "TRAIN_SEQ_LEN=1024" "ROPE_BASE=50000"
    run_one "exp55c_h100_seq2048_rope50k" "TRAIN_SEQ_LEN=2048" "ROPE_BASE=50000"
    ;;
  56)
    run_one "exp56a_h100_muon_steps3" "MUON_BACKEND_STEPS=3"
    run_one "exp56b_h100_muon_steps7" "MUON_BACKEND_STEPS=7"
    run_one "exp56c_h100_muon_mom090" "MUON_MOMENTUM=0.90" "MUON_MOMENTUM_WARMUP_STEPS=0"
    run_one "exp56d_h100_muon_mom095" "MUON_MOMENTUM=0.95" "MUON_MOMENTUM_WARMUP_STEPS=0"
    ;;
  57)
    blocked "NUM_UNIQUE_BLOCKS is not implemented in train_gpt.py"
    ;;
  58)
    blocked "alternating cheap/full blocks are not implemented in train_gpt.py"
    ;;
  59)
    blocked "LOW_RANK_MLP_RANK is not implemented in train_gpt.py"
    ;;
  60)
    run_one "exp60a_h100_clip05" "POST_STEP_WEIGHT_CLIP=0.5"
    run_one "exp60b_h100_clip025" "POST_STEP_WEIGHT_CLIP=0.25"
    ;;
  61)
    run_one "exp61a_h100_untied" "TIE_EMBEDDINGS=0"
    echo "Skipping the LM_HEAD_DELTA_RANK branch from local exp18 because train_gpt.py does not implement it."
    ;;
  62)
    blocked "sp512/sp2048 tokenizer assets are not present in data/tokenizers or data/datasets"
    ;;
  63)
    blocked "EVAL_EXTRA_PASSES is not implemented in train_gpt.py"
    ;;
  64)
    run_one "exp64_h100_seq512_clip05" "TRAIN_SEQ_LEN=512" "POST_STEP_WEIGHT_CLIP=0.5"
    ;;
  65)
    run_one "exp65_h100_seq512_clip05_untied" "TRAIN_SEQ_LEN=512" "POST_STEP_WEIGHT_CLIP=0.5" "TIE_EMBEDDINGS=0"
    ;;
  66)
    blocked "the local exp23 longer-run result is not comparable to a 10-minute single-A40 run"
    ;;
  67)
    blocked "NUM_UNIQUE_BLOCKS is not implemented in train_gpt.py"
    ;;
  68)
    blocked "MTP_TOKENS is not implemented in train_gpt.py"
    ;;
  69)
    run_one "exp69_h100_bigram2048_seq512_clip05" "BIGRAM_HASH_VOCAB=2048" "TRAIN_SEQ_LEN=512" "POST_STEP_WEIGHT_CLIP=0.5"
    ;;
  70)
    blocked "USE_VALUE_EMBED is not implemented in train_gpt.py"
    ;;
  71)
    blocked "PARTIAL_KEY_OFFSET_DIMS is not implemented in train_gpt.py"
    ;;
  72)
    blocked "USE_SECOND_INPUT_EMBED is not implemented in train_gpt.py"
    ;;
  73)
    blocked "USE_TOKEN_SMEAR_FORWARD is not implemented in train_gpt.py"
    ;;
  74)
    blocked "local exp31 was never completed"
    ;;
  75)
    blocked "local exp32 was never completed"
    ;;
  76)
    blocked "local exp33 was never completed"
    ;;
  77)
    blocked "local exp34 was never completed"
    ;;
  78)
    run_one "exp78_h100_bigram2048_seq512_clip05_untied" "BIGRAM_HASH_VOCAB=2048" "TRAIN_SEQ_LEN=512" "POST_STEP_WEIGHT_CLIP=0.5" "TIE_EMBEDDINGS=0"
    ;;
  79)
    blocked "the local exp36 longer-run result is not comparable to a 10-minute single-A40 run"
    ;;
  80)
    blocked "the local exp37 warmup experiment was MLX-specific and does not transfer cleanly"
    ;;
  *)
    print_usage
    exit 1
    ;;
esac
