# Experiment 07: Sweep Train Batch Tokens

## hypothesis

There is a better optimization sweet spot than `TRAIN_BATCH_TOKENS=4096`; changing batch size will alter update noise and throughput enough to improve final local `val_bpb`.

## changes

- Start from `mlx_local_v2`
- Compare `TRAIN_BATCH_TOKENS=2048`, `4096`, and `8192`
- Keep architecture and validation proxy fixed

## experiment results

Status: Completed

- Validation protocol: `VAL_MAX_TOKENS=1048576`
- Comparison midpoint baseline (`mlx_local_v2_subset`, `TRAIN_BATCH_TOKENS=4096`):
  - `final_int8_zlib_roundtrip_exact val_bpb:2.81933844`
  - `serialized_model_int8_zlib:737967 bytes`
- Run ID: `exp07_bs2048`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.94057187`
  - `serialized_model_int8_zlib:737742 bytes`
- Run ID: `exp07_bs8192`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.68273118`
  - `serialized_model_int8_zlib:737759 bytes`

## analysis and conclusion

This sweep produced a strong and clean result because artifact size stayed essentially constant while optimization behavior changed dramatically.

`TRAIN_BATCH_TOKENS=2048` was clearly too small in this 100-step local regime. Its final proxy `val_bpb` was `2.94057187`, much worse than the `4096` midpoint baseline.

`TRAIN_BATCH_TOKENS=8192` was clearly better. It improved the final proxy `val_bpb` to `2.68273118`, which is a large gain over the `4096` midpoint baseline `2.81933844`, with virtually no artifact-size change.

Conclusion: the local 100-step setup strongly prefers a larger training batch. For subsequent local tuning, `TRAIN_BATCH_TOKENS=8192` should replace `4096` as the default unless a later experiment proves otherwise.
