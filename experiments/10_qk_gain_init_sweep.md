# Experiment 10: Sweep QK Gain Init

## hypothesis

Changing `QK_GAIN_INIT` will alter how sharp attention starts out, which may materially affect small-model learning dynamics.

## changes

- Start from `mlx_local_v2`
- Compare `QK_GAIN_INIT=1.0`, `1.5`, and `2.0`
- Keep architecture and validation proxy fixed

## experiment results

Status: Completed

- Validation protocol: `VAL_MAX_TOKENS=1048576`
- Starting point for this sweep: the stronger local recipe from experiment 09
  - `TRAIN_BATCH_TOKENS=8192`
  - lower learning rates
  - `MAX_WALLCLOCK_SECONDS=0`
  - `WARMDOWN_ITERS=20`
- Comparison point (`exp09_wd20`, `QK_GAIN_INIT=1.5`):
  - `final_int8_zlib_roundtrip_exact val_bpb:2.63387926`
  - `serialized_model_int8_zlib:732687 bytes`
- Run ID: `exp10_qk1`
  - `QK_GAIN_INIT=1.0`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.64260697`
  - `serialized_model_int8_zlib:732508 bytes`
- Run ID: `exp10_qk2`
  - `QK_GAIN_INIT=2.0`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.62256258`
  - `serialized_model_int8_zlib:732499 bytes`

## analysis and conclusion

This sweep shows that attention scaling at initialization still matters after the optimizer improvements from the earlier experiments. The lower value `1.0` was slightly worse than the `1.5` comparison point, while the higher value `2.0` was better.

The best result was `QK_GAIN_INIT=2.0`, which improved the final proxy `val_bpb` from `2.63387926` to `2.62256258` with no meaningful size penalty.

Conclusion: the current strongest 100-step local recipe prefers a slightly sharper attention initialization than the baseline. `QK_GAIN_INIT=2.0` should replace `1.5` for subsequent local tuning.
