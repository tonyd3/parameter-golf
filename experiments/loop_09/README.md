# Loop 09

This loop treats `persistent_memory16` as the new fixed-`600` local anchor and tests whether more memory, Primer, talking-heads, or shared-depth hybrids can beat it.

Anchor comparison target:

- `loop08_exp05_persistent_memory16_best`
- `final_int8_zlib_roundtrip_exact val_bpb:1.90753035`
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
- `PERSISTENT_MEMORY_TOKENS=16`
- `TIE_EMBEDDINGS=0`
- `POST_STEP_WEIGHT_CLIP=0.0`

## Ranked Hypotheses

1. `01_pmem16_anchor`
   The new best result should reproduce cleanly before we stack more changes on top.
2. `02_pmem24_best`
   More persistent memory may improve further before diminishing returns.
3. `03_pmem32_best`
   The memory sweep may still improve at 32 slots.
4. `04_pmem16_primer5`
   Persistent memory and Primer local bias may compound.
5. `05_pmem24_primer5`
   A larger memory bank plus Primer may outperform either alone.
6. `06_pmem16_no_value`
   Persistent memory may make value embeddings redundant.
7. `07_pmem16_shared3`
   The larger memory bank may improve the best shared-depth quality/bytes hybrid.
8. `08_pmem16_primer5_shared3`
   Shared depth may benefit from both persistent memory and Primer.
9. `09_pmem16_talking_heads`
   Head mixing may help the model use memory slots more effectively.
10. `10_pmem16_no_bigram`
   Persistent memory may reduce the need for an explicit bigram hash path.

## Current Read

- Best result:
  - `loop09_exp05_pmem24_primer5`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.89137299`
  - `compressed_size_bytes:1707973`
- Strong follow-ups:
  - `loop09_exp09_pmem16_talking_heads` at `1.89217451`
  - `loop09_exp04_pmem16_primer5` at `1.89522831`
  - `loop09_exp02_pmem24_best` at `1.90110292`
- Sweep read:
  - persistent memory improved from `16` to `24`
  - persistent memory regressed again at `32`
  - Primer compounded strongly with persistent memory
- Clear negatives:
  - `loop09_exp06_pmem16_no_value`
  - `loop09_exp10_pmem16_no_bigram`
- Best quality/bytes hybrid:
  - `loop09_exp08_pmem16_primer5_shared3`
  - `1.94156468` at `983048` bytes
