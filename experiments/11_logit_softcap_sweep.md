# Experiment 11: Sweep Logit Softcap

## hypothesis

Changing `LOGIT_SOFTCAP` will alter output stability and may reduce harmful logit outliers, which could help both training and post-quantized evaluation.

## changes

- Start from `mlx_local_v2`
- Compare `LOGIT_SOFTCAP=15`, `30`, and `50`
- Keep architecture and validation proxy fixed

## experiment results

- Comparison point: current best 100-step recipe from experiment 10
  - `TRAIN_BATCH_TOKENS=8192`
  - `TIED_EMBED_LR=0.0375`
  - `MATRIX_LR=0.03`
  - `SCALAR_LR=0.03`
  - `WARMDOWN_ITERS=20`
  - `QK_GAIN_INIT=2.0`
  - `LOGIT_SOFTCAP=30`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.62256258`
  - `serialized_model_int8_zlib:732499 bytes`
- `exp11_softcap15`
  - `LOGIT_SOFTCAP=15`
  - `final_int8_zlib_roundtrip_exact val_loss:4.36734104`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.61667811`
  - `serialized_model_int8_zlib:732922 bytes`
- `exp11_softcap50`
  - `LOGIT_SOFTCAP=50`
  - `final_int8_zlib_roundtrip_exact val_loss:4.37789917`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.62300398`
  - `serialized_model_int8_zlib:732387 bytes`

## analysis and conclusion

Lowering the softcap from `30` to `15` improved the post-quantized score, while raising it to `50` slightly hurt it. That suggests the smaller cap is helping control logit outliers or otherwise stabilizing the output distribution in a way that survives the int8 + zlib roundtrip.

Conclusion: keep `LOGIT_SOFTCAP=15` in the current best 100-step local recipe.
