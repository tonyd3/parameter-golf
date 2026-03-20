# Loop 12

This loop is the next single-H100 candidate pack. It uses the best proven remote schedule as the anchor and compounds only the local improvements that are both portable to `train_gpt.py` and plausible at baseline scale.

Target environment:

- `1xH100`
- `torchrun --standalone --nproc_per_node=1`
- `MAX_WALLCLOCK_SECONDS=600`

Anchor comparison target:

- `exp40_1gpu_h100_sched`
- `final_int8_zlib_roundtrip_exact val_bpb:1.50182515`

Shared schedule assumptions:

- `ATTN_BACKEND=flash`
- `MIN_LR_SCALE=0.1`
- `TRAIN_SEQ_LEN_START=512`
- `SEQ_LEN_WARMUP_STEPS=100`
- `WARMUP_STEPS=20`
- `TRAIN_SEQ_LEN=1024`
- `VAL_LOSS_EVERY=0`
- `MAX_WALLCLOCK_SECONDS=600`

Shared model family:

- `NUM_LAYERS=9`
- `MODEL_DIM=512`
- `NUM_HEADS=8`
- `NUM_KV_HEADS=4`
- `MLP_MULT=2`
- `TIE_EMBEDDINGS=1` unless explicitly tested otherwise

Distilled transfer assumptions from local loops:

- `PARTIAL_KEY_OFFSET_DIMS=32` is the most plausible PKO width
- `BIGRAM_HASH_VOCAB=2048` is the most stable lexical signal
- `USE_VALUE_EMBED=1` is more reliable than `USE_SECOND_INPUT_EMBED=1`
- `altcheap` should be dropped from the main path
- larger token batches deserve real remote testing

## Ranked Candidates

1. `01_sched_anchor_repro`
   Reproduce the best known remote schedule before layering architecture changes onto it.
2. `02_pko32_bigram`
   Lowest-risk structural upgrade from local evidence.
3. `03_pko32_bigram_value`
   Strongest simple lexical compound on top of the lower-risk PKO path.
4. `04_pko32_bigram_value_secondinput`
   Full lexical stack on top of the PKO32 path.
5. `05_pko32_bigram_value_batch655360`
   Test whether the strongest simple structural stack wants a larger batch on H100.
6. `06_pko32_bigram_value_batch786432`
   Push the batch-size hypothesis harder while staying on the same model family.
7. `07_pko32_bigram_value_warmdown180`
   Test whether a longer cooldown helps at remote scale.
8. `08_pko32_bigram_value_untied`
   Revisit untied output weights in a cleaner, more stable context than the earlier failed remote run.
9. `09_pko64_bigram_value_noalt`
   Higher-risk PKO width test without the old altcheap interaction.
10. `10_shared3_pko32_bigram`
   Quality/bytes hybrid candidate for remote transfer.

## Current Read

Pending runs.
