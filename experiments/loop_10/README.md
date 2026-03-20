# Loop 10

This loop treats `pmem24 + primer5` as the new fixed-`600` local anchor and tests tight refinements around the new peak before adding a few targeted compounds and isolations.

Anchor comparison target:

- `loop09_exp05_pmem24_primer5`
- `final_int8_zlib_roundtrip_exact val_bpb:1.89137299`
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
- `PERSISTENT_MEMORY_TOKENS=24`
- `PRIMER_DEPTHWISE_KERNEL=5`

## Ranked Hypotheses

1. `01_pmem24_primer5_anchor`
   The new frontier should reproduce cleanly before we build on it.
2. `02_pmem20_primer5`
   The memory sweep may peak slightly below `24`.
3. `03_pmem28_primer5`
   The true peak may sit slightly above `24`.
4. `04_pmem24_primer3`
   The current best stack may prefer a shorter Primer kernel than `5`.
5. `05_pmem24_primer7`
   The current best stack may prefer a slightly longer local receptive field than `5`.
6. `06_pmem24_primer5_talking_heads`
   Talking-heads may compound with the new frontier and push quality further, even if runtime suffers.
7. `07_pmem24_primer5_shared3`
   The best quality stack may transfer into a stronger size-aware shared-depth hybrid.
8. `08_pmem24_primer5_second_input`
   The older lexical-superstack signal may still add value on top of persistent memory plus Primer.
9. `09_pmem24_primer5_no_altcheap`
   The alternating cheap-block rule may no longer be helping once persistent memory and Primer are in place.
10. `10_pmem24_primer5_batch24576`
   A larger fixed-600 token budget per step may still improve this regime.

## Current Read

Pending runs.
