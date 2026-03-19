# Loop 04

This loop is the first fixed-`600` local moonshot loop.

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
- `TIE_EMBEDDINGS=0`
- `POST_STEP_WEIGHT_CLIP=0.0`

## Ranked Hypotheses

1. `01_lexical_superstack`
   Value and second-input features may compound when added together on top of the best stack.
2. `02_shared2_layers8`
   Shared blocks plus more logical depth may improve quality-per-byte and quality-per-step.
3. `03_shared3_layers12`
   A slightly less aggressive shared stack may beat the 2-of-8 version.
4. `04_shared2_layers8_lexical`
   Rich lexical features may work especially well when compute is reused through shared depth.
5. `05_partial_key_offset16`
   Partial key offset may become useful on a much stronger base recipe.
6. `06_mtp2_best`
   Multi-token prediction may help on the current mature stack even though the naive early port lost.
7. `07_altcheap_layers8`
   Extra logical depth with alternating cheap blocks may outperform the plain 4-layer stack.
8. `08_lowrank32_dim160`
   A wider but low-rank MLP model may buy expressivity without a full byte explosion.
9. `09_token_smear_best`
   Token smearing may help once the optimizer and batch regime are stronger.
10. `10_shared1_layers12`
   An extreme recurrent/shared stack might discover a radically better compute-heavy, weight-light regime.

## Current Read

- Best moonshot quality result so far:
  - `loop04_exp05_partialkey16`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.99532927`
- Second-best moonshot quality result so far:
  - `loop04_exp07_altcheap8`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.04854176`
- Best moonshot size-efficiency direction so far:
  - shared-depth stacks
  - `loop04_exp02_shared2_layers8`, `loop04_exp03_shared3_layers12`, and `loop04_exp10_shared1_layers12`
  - all are weaker on quality but dramatically smaller after compression
- Clear moonshot loser so far:
  - `loop04_exp06_mtp2` and `loop04_exp09_tokensmear`
  - both objective-smear style ports remain clearly negative on the stronger stack
