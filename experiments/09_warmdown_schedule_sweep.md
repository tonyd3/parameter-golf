# Experiment 09: Sweep Warmdown Schedule

## hypothesis

The current `WARMDOWN_ITERS` schedule may be too gentle or too aggressive for a short run, and a different warmdown could improve the final state more than it changes training speed.

## changes

- Start from the stronger local regime found in experiments 07 and 08:
  - `TRAIN_BATCH_TOKENS=8192`
  - lower learning rates from `exp08_lr_low`
- For local runs, switch to iteration-based warmdown by setting `MAX_WALLCLOCK_SECONDS=0`
- Compare effective no-warmdown against `WARMDOWN_ITERS=20` and `WARMDOWN_ITERS=50`

## experiment results

Status: Completed

- Validation protocol: `VAL_MAX_TOKENS=1048576`
- Comparison point (`exp08_lr_low`, effectively no warmdown in the short local wallclock regime):
  - `final_int8_zlib_roundtrip_exact val_bpb:2.67582592`
  - `serialized_model_int8_zlib:733860 bytes`
- Run ID: `exp09_wd20`
  - `MAX_WALLCLOCK_SECONDS=0`, `WARMDOWN_ITERS=20`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.63387926`
  - `serialized_model_int8_zlib:732687 bytes`
- Run ID: `exp09_wd50`
  - `MAX_WALLCLOCK_SECONDS=0`, `WARMDOWN_ITERS=50`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.64235098`
  - `serialized_model_int8_zlib:730227 bytes`

## analysis and conclusion

The original local setup was not actually exercising warmdown because the run was too short relative to the 600-second wallclock cap. Switching to iteration-based warmdown made the experiment meaningful.

Both explicit warmdown variants beat the no-warmdown comparison point, which means the end-of-run schedule matters even in a 100-step proxy run. `WARMDOWN_ITERS=20` was best at `2.63387926`, while `WARMDOWN_ITERS=50` was slightly worse at `2.64235098`.

Conclusion: the local regime benefits from a short late decay, and `WARMDOWN_ITERS=20` is the best schedule tested so far. This becomes part of the strongest 100-step local recipe.
