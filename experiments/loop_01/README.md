# Loop 01

Current anchor run:

- `exp43_1gpu_seqwarm150_minlr01`
- `final_int8_zlib_roundtrip_exact val_bpb:1.49781690`
- baseline-scale `9x512`, `NUM_KV_HEADS=4`, tied embeddings, `ATTN_BACKEND=flash`
- winning schedule additions:
  - `MIN_LR_SCALE=0.1`
  - `TRAIN_SEQ_LEN_START=512`
  - `SEQ_LEN_WARMUP_STEPS=150`

This loop is a controlled follow-up to isolate which parts of the winning remote schedule are real, tune the best schedule more finely, and test one bounded wildcard.

## Ranked Hypotheses

1. `01_seqwarm_only`
   Sequence warmup carries most of the win, even without a nonzero LR floor.
2. `02_minlr_only`
   A nonzero LR floor carries most of the win, even without sequence warmup.
3. `03_seqwarm_200`
   Keeping the model at `512` tokens for longer than `150` steps will improve final quality.
4. `04_seqwarm_050`
   The short-sequence phase only needs to be brief; `50` steps may outperform `150`.
5. `05_seqstart_256`
   A more aggressive early short-context phase will buy better early optimization.
6. `06_minlr_005`
   The current LR floor is slightly too high; `0.05` will preserve more learning flexibility.
7. `07_minlr_020`
   The current LR floor is too low; `0.2` will preserve more late-run progress.
8. `08_batch_393216`
   A smaller token batch will improve wallclock efficiency enough to beat the current best run.
9. `09_batch_655360`
   A larger token batch will improve optimization stability enough to beat the current best run.
10. `10_bigram2048_best_sched`
   Bigram hash embeddings may help at baseline scale if added on top of the best remote schedule rather than the failed `KV1 + untied` compound run.

## Comparison Target

Unless otherwise stated, every experiment in this loop compares against:

- `exp43_1gpu_seqwarm150_minlr01`
- `final_int8_zlib_roundtrip_exact val_bpb:1.49781690`
- `Total submission size int8+zlib:10177280 bytes`
