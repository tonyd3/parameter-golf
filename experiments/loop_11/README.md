# Loop 11

This loop combines the strongest fixed-`600` local wins so far and adds two seeded neighborhood-jitter variants to avoid overfitting to purely hand-picked combinations.

Anchor comparison target:

- `loop10_exp10_pmem24_primer5_batch24576`
- `final_int8_zlib_roundtrip_exact val_bpb:1.84887808`
- fixed local comparison budget:
  - `ITERATIONS=600`
  - `VAL_MAX_TOKENS=1048576`

Distilled learning carried into this loop:

- `PERSISTENT_MEMORY_TOKENS=24`
- `PARTIAL_KEY_OFFSET_DIMS=32`
- `BIGRAM_HASH_VOCAB=2048`
- `USE_VALUE_EMBED=1`
- `TIE_EMBEDDINGS=0`
- `POST_STEP_WEIGHT_CLIP=0.0`
- `WARMUP_STEPS=40`
- `TRAIN_SEQ_LEN=512`
- `WARMDOWN_ITERS=120`

## Ranked Hypotheses

1. `01_primer3_noalt_batch24576`
   The strongest three wins should compound cleanly.
2. `02_primer3_batch24576`
   Primer3 may be doing most of the work without needing the larger no-altcheap model.
3. `03_noalt_batch24576`
   No-altcheap may be doing most of the work without needing Primer3.
4. `04_primer3_noalt_batch28672`
   The combined stack may still benefit from a larger batch.
5. `05_primer3_noalt_batch32768`
   The best stack may keep improving at an even larger batch.
6. `06_primer3_noalt_batch24576_warmdown180`
   The stronger combined stack may want a longer cooldown.
7. `07_primer3_noalt_batch24576_talking_heads`
   Talking-heads may become worthwhile on the stronger combined stack.
8. `08_primer3_noalt_batch24576_second_input`
   The lexical add-on may finally pay off when attached to the strongest combined core.
9. `09_seed1337_a`
   Weighted random neighborhood search may surface a non-obvious local improvement.
10. `10_seed1337_b`
   A second weighted random neighborhood sample may find a better nearby basin.

## Current Read

Pending runs.
