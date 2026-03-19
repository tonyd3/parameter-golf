# Loop 07

This loop is the first single-H100 candidate pack built from the strongest local moonshots that are now portable to `train_gpt.py`.

Target environment:

- `1xH100`
- `torchrun --standalone --nproc_per_node=1`
- `MAX_WALLCLOCK_SECONDS=600`

Shared remote anchor assumptions:

- best current single-H100 schedule:
  - `ATTN_BACKEND=flash`
  - `MIN_LR_SCALE=0.1`
  - `TRAIN_SEQ_LEN_START=512`
  - `SEQ_LEN_WARMUP_STEPS=100`
  - `WARMUP_STEPS=20`
- baseline-scale model family:
  - `NUM_LAYERS=9`
  - `MODEL_DIM=512`
  - `NUM_HEADS=8`
  - `NUM_KV_HEADS=4`
  - `MLP_MULT=2`
  - `TRAIN_BATCH_TOKENS=524288`
  - `TRAIN_SEQ_LEN=1024`

## Ranked Candidates

1. `01_sched_anchor`
   Best existing proven single-H100 schedule anchor.
2. `02_pko32_bigram`
   Lower-risk PKO port with the strongest stable lexical signal.
3. `03_pko64_bigram`
   Full-head PKO analog of the local PKO winner.
4. `04_pko64_value`
   Full-head PKO plus the strongest simple lexical branch.
5. `05_pko64_lexical_superstack`
   Full-head PKO plus both lexical branches.
6. `06_pko64_altcheap`
   Full-head PKO plus alternating cheap depth.
7. `07_pko64_altcheap_value`
   Closest H100 analog of the best local fixed-600 result.
8. `08_pko64_shared3`
   Best quality/bytes hybrid adapted to baseline scale.
9. `09_pko32_altcheap_value`
   Lower-risk version of the best local analog with smaller PKO.
10. `10_pko64_lexical_untied`
    Highest-upside aggressive candidate that also tests untied output weights.

## Current Read

- Best proven remote baseline:
  - `exp40_1gpu_h100_sched`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.50182515`
- Best local transferable family:
  - `PKO32`
  - alternating cheap depth
  - value / lexical features
- Main uncertainty:
  - how much of the local `PKO` and lexical gains survive at baseline scale on a real H100 run
