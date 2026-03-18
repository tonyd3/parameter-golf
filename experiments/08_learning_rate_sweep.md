# Experiment 08: Sweep Learning Rates

## hypothesis

The baseline split learning rates may be slightly mis-scaled for this small regime, so a coordinated sweep of `TIED_EMBED_LR`, `MATRIX_LR`, and `SCALAR_LR` will improve final local quality.

## changes

- Start from `mlx_local_v2`
- Try all three learning rates at `-25%` and `+25%`
- Keep architecture and validation proxy fixed

## experiment results

Status: Completed

- Validation protocol: `VAL_MAX_TOKENS=1048576`
- Starting point for this sweep: the stronger batch-size setting from experiment 07, `TRAIN_BATCH_TOKENS=8192`
- Comparison point (`exp07_bs8192`):
  - `final_int8_zlib_roundtrip_exact val_bpb:2.68273118`
  - `serialized_model_int8_zlib:737759 bytes`
- Run ID: `exp08_lr_low`
  - `TIED_EMBED_LR=0.0375`, `MATRIX_LR=0.03`, `SCALAR_LR=0.03`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.67582592`
  - `serialized_model_int8_zlib:733860 bytes`
- Run ID: `exp08_lr_high`
  - `TIED_EMBED_LR=0.0625`, `MATRIX_LR=0.05`, `SCALAR_LR=0.05`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.68997241`
  - `serialized_model_int8_zlib:740043 bytes`

## analysis and conclusion

This sweep shows that the local regime is somewhat sensitive to learning rate, but not dramatically so. Both variants stayed in roughly the same neighborhood, which is a good sign that the optimizer split is reasonably stable.

The lower-LR variant was best. It improved the final proxy `val_bpb` from `2.68273118` on the `8192` batch comparison point to `2.67582592`. The higher-LR variant was worse at `2.68997241`.

Conclusion: once batch size is fixed at `8192`, slightly lowering the learning rates is helpful. For subsequent local tuning, the low-LR configuration should replace the original learning-rate split as the default 100-step local regime.
