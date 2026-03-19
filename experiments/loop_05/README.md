# Loop 05

This loop compounds the strongest moonshot from `loop_04`, `PARTIAL_KEY_OFFSET_DIMS=16`, with the next most plausible structural and lexical ideas while keeping `ITERATIONS=600` fixed.

Anchor run:

- `loop04_exp05_partialkey16`
- `final_int8_zlib_roundtrip_exact val_bpb:1.99532927`
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
- `PARTIAL_KEY_OFFSET_DIMS=16`
- `TIE_EMBEDDINGS=0`
- `POST_STEP_WEIGHT_CLIP=0.0`

## Ranked Hypotheses

1. `01_pko16_altcheap8`
   Partial key offset and alternating cheap depth may compound into the strongest quality run yet.
2. `02_pko16_lexical_superstack`
   PKO may combine well with richer lexical side channels.
3. `03_pko08`
   The `16`-dim offset may be too large; a smaller offset could regularize better.
4. `04_pko32`
   The PKO sweet spot may be larger than `16` on the stronger stack.
5. `05_pko16_shared3_layers12`
   Shared-depth quality/byte wins may improve once PKO repairs the attention side.
6. `06_pko16_shared2_layers8`
   More aggressive shared depth may become viable with PKO added.
7. `07_pko16_lowrank32_dim160`
   A wider low-rank model may benefit more once PKO is already helping induction.
8. `08_pko16_value_embed`
   Value embeddings may become complementary rather than redundant once PKO is active.
9. `09_pko16_second_input`
   Second-input lexical features may stack with PKO more cleanly than full lexical superstack.
10. `10_pko16_shared1_layers12`
   The extreme shared-depth regime may become much more usable once PKO is present.

## Current Read

- Best result so far:
  - `loop05_exp04_pko32`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.96638761`
- Best size-efficiency direction so far:
  - `loop05_exp05_pko16_shared3` for balanced quality/bytes
  - `loop05_exp10_pko16_shared1` for the absolute smallest artifact
- Clear loser so far:
  - `loop05_exp03_pko08` and `loop05_exp07_pko16_lowrank160`
  - shrinking PKO and widening through low-rank MLPs both failed cleanly
