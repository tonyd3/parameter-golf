# Loop 06

This loop treats `PKO32` as the new fixed-`600` local anchor and tests whether the best `PKO16` compounds still improve when the stronger attention bias is carried forward.

Anchor run:

- `loop05_exp04_pko32`
- `final_int8_zlib_roundtrip_exact val_bpb:1.96638761`
- fixed local comparison budget:
  - `ITERATIONS=600`
  - `VAL_MAX_TOKENS=1048576`

Base stack for this loop:

- `TRAIN_BATCH_TOKENS=16384`
- `TRAIN_SEQ_LEN=512`
- `WARMUP_STEPS=40`
- `WARMDOWN_ITERS=120`
- `MODEL_DIM=128`
- `NUM_LAYERS=4`
- `NUM_HEADS=4`
- `NUM_KV_HEADS=2`
- `MLP_MULT=1`
- `BIGRAM_HASH_VOCAB=2048`
- `PARTIAL_KEY_OFFSET_DIMS=32`
- `TIE_EMBEDDINGS=0`
- `POST_STEP_WEIGHT_CLIP=0.0`

## Ranked Hypotheses

1. `01_pko32_altcheap8`
   The best `PKO16` quality compound may improve again when upgraded to `PKO32`.
2. `02_pko32_lexical_superstack`
   The best lexical compound may also improve when upgraded to `PKO32`.
3. `03_pko32_value_embed`
   The cleaner value-only lexical branch may compound better than the full lexical superstack.
4. `04_pko32_second_input`
   Second-input features may scale more cleanly under `PKO32` than under `PKO16`.
5. `05_pko48`
   The PKO sweet spot may still be above `32`.
6. `06_pko64`
   The upward PKO sweep may continue, though this is a higher-risk overshoot test.
7. `07_pko32_shared3_layers12`
   The best quality/bytes shared-depth stack may improve under `PKO32`.
8. `08_pko32_shared2_layers8`
   The more aggressive shared-depth stack may become viable with the stronger PKO bias.
9. `09_pko32_altcheap8_value`
   Alternating cheap depth plus value embeddings may outperform the larger lexical superstack.
10. `10_pko32_shared1_layers12`
   The extreme shared-depth size frontier may become useful enough to revisit.

## Current Read

- Best result so far:
  - `loop06_exp09_pko32_altcheap8_value`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.92565973`
- Best size-efficiency direction so far:
  - `loop06_exp07_pko32_shared3` for balanced quality/bytes
  - `loop06_exp10_pko32_shared1` for the absolute smallest artifact
- Clear loser so far:
  - `loop06_exp05_pko48` and `loop06_exp06_pko64`
  - the PKO sweep appears to have peaked at `32`
