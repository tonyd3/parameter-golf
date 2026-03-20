# Loop 08

This loop tested research-backed local moonshots on top of the current best fixed-`600` local stack.

Anchor comparison target:

- `loop06_exp09_pko32_altcheap8_value`
- `final_int8_zlib_roundtrip_exact val_bpb:1.92565973`
- fixed local comparison budget:
  - `ITERATIONS=600`
  - `VAL_MAX_TOKENS=1048576`

Base stack for most experiments:

- `TRAIN_BATCH_TOKENS=16384`
- `TRAIN_SEQ_LEN=512`
- `WARMUP_STEPS=40`
- `WARMDOWN_ITERS=120`
- `MODEL_DIM=128`
- `NUM_LAYERS=8`
- `NUM_HEADS=4`
- `NUM_KV_HEADS=2`
- `MLP_MULT=1`
- `CHEAP_BLOCK_EVERY=2`
- `CHEAP_BLOCK_OFFSET=1`
- `CHEAP_BLOCK_MLP_MULT=0`
- `BIGRAM_HASH_VOCAB=2048`
- `USE_VALUE_EMBED=1`
- `PARTIAL_KEY_OFFSET_DIMS=32`
- `TIE_EMBEDDINGS=0`
- `POST_STEP_WEIGHT_CLIP=0.0`

## Ranked Hypotheses

1. `01_primer3_best`
   Primer-style local bias in q/k/v may improve the strongest current stack.
2. `02_primer5_best`
   A larger Primer kernel may beat `k=3` if the model wants a slightly longer local receptive field.
3. `03_talking_heads_best`
   Cross-head mixing may help a tiny 4-head model more than a standard attention head layout.
4. `04_persistent_memory8_best`
   A small persistent memory may substitute for some FFN capacity.
5. `05_persistent_memory16_best`
   More memory slots may help if the 8-slot memory is too constrained.
6. `06_hyperconnections_best`
   A two-stream residual path may improve optimization and deep signal transport.
7. `07_swiglu_best`
   Budget-matched SwiGLU may beat relu^2 at the same rough parameter budget.
8. `08_delight_schedule8`
   Block-wise uneven allocation may beat the current crude alternating-cheap schedule.
9. `09_persistent8_shared3`
   Persistent memory may improve the best quality/bytes shared-depth stack.
10. `10_primer3_shared3`
   Primer local bias may improve shared-depth recurrence more effectively than lexical-only features.

## Current Read

- Best result:
  - `loop08_exp05_persistent_memory16_best`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.90753035`
  - `compressed_size_bytes:1658295`
- Strong follow-ups:
  - `loop08_exp04_persistent_memory8_best` at `1.91069757`
  - `loop08_exp03_talking_heads_best` at `1.91089170`
  - `loop08_exp02_primer5_best` at `1.91378580`
- Clear negatives:
  - `loop08_exp06_hyperconnections_best`
  - `loop08_exp07_swiglu_best`
  - `loop08_exp08_delight_schedule8`
- Best quality/bytes hybrid:
  - `loop08_exp09_persistent8_shared3`
  - `1.94899990` at `964489` bytes
