# Loop 03 Experiment 01: Batch 16384 + No Clip

## command

```bash
RUN_ID=loop03_pilot_batch16384_noclip \
DATA_PATH="$PWD/data/datasets/fineweb10B_sp1024" \
TOKENIZER_PATH="$PWD/data/tokenizers/fineweb_1024_bpe.model" \
VOCAB_SIZE=1024 \
ITERATIONS=600 \
WARMUP_STEPS=40 \
TRAIN_LOG_EVERY=30 \
TRAIN_BATCH_TOKENS=16384 \
GRAD_ACCUM_STEPS=1 \
TRAIN_SEQ_LEN=512 \
VAL_LOSS_EVERY=0 \
VAL_BATCH_SIZE=65536 \
VAL_MAX_TOKENS=1048576 \
MAX_WALLCLOCK_SECONDS=0 \
WARMDOWN_ITERS=60 \
LOGIT_CHUNK_TOKENS=4096 \
MODEL_DIM=128 \
NUM_LAYERS=4 \
NUM_HEADS=4 \
NUM_KV_HEADS=2 \
MLP_MULT=1 \
BIGRAM_HASH_VOCAB=2048 \
TIE_EMBEDDINGS=0 \
TIED_EMBED_LR=0.0375 \
MATRIX_LR=0.03 \
SCALAR_LR=0.03 \
QK_GAIN_INIT=2.0 \
LOGIT_SOFTCAP=15 \
MUON_BACKEND_STEPS=7 \
POST_STEP_WEIGHT_CLIP=0.0 \
.venv/bin/python3 train_gpt_mlx.py
```

## hypothesis

`TRAIN_BATCH_TOKENS=16384` and `POST_STEP_WEIGHT_CLIP=0.0` were the two strongest independent wins from `loop_02`. Combining them should beat the current local best run, `loop02_exp10_batch16384`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp10_batch16384`
- `log_path:logs/loop03_pilot_batch16384_noclip.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.4672`
- `pre_quant_val_bpb:2.0774`
- `final_int8_zlib_roundtrip_exact val_loss:3.46760154`
- `final_int8_zlib_roundtrip_exact val_bpb:2.07760213`
- `compressed_size_bytes:1104375`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was supported. The combined run improved from `2.12161593` to `2.07760213`, a gain of about `0.0440 val_bpb`, which is larger than either individual win alone. The compressed artifact increased from `1044469` bytes to `1104375` bytes, but the quality improvement is strong enough that this is the new local quality frontier.
