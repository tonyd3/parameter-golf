# Experiment 14: Add Layer Sharing / Recurrence

## hypothesis

Reusing block weights across multiple layers will improve parameter efficiency because repeated computation may be more valuable than allocating fresh weights at every depth.

## changes

- Add a `NUM_UNIQUE_BLOCKS` knob to `train_gpt_mlx.py`
- Keep the logical depth at `NUM_LAYERS=4`, but allow those 4 logical layers to reuse fewer underlying block weights
- Start from the current best 100-step local recipe from experiment 13:
  - `TRAIN_BATCH_TOKENS=8192`
  - `TIED_EMBED_LR=0.0375`
  - `MATRIX_LR=0.03`
  - `SCALAR_LR=0.03`
  - `WARMDOWN_ITERS=20`
  - `QK_GAIN_INIT=2.0`
  - `LOGIT_SOFTCAP=15`
  - `MUON_BACKEND_STEPS=7`
  - comparison point: `val_bpb 2.61415456`, `732868 bytes`
- Compare `NUM_UNIQUE_BLOCKS=2` and `1`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports `NUM_UNIQUE_BLOCKS`
  - `0` or unset keeps the original behavior: one unique block per logical layer
  - positive values let multiple logical layers reuse the same block weights
- `exp14_share2`
  - `NUM_UNIQUE_BLOCKS=2`
  - `model_params:296200`
  - `final_int8_zlib_roundtrip_exact val_loss:4.37944031`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.62392734`
  - `serialized_model_int8_zlib:426041 bytes`
- `exp14_share1`
  - `NUM_UNIQUE_BLOCKS=1`
  - `model_params:213764`
  - `final_int8_zlib_roundtrip_exact val_loss:4.41518545`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.64534393`
  - `serialized_model_int8_zlib:272649 bytes`

## analysis and conclusion

Two-way layer sharing was much more promising than the all-shared recurrent variant. Going from 4 unique blocks to 2 unique blocks cut the compressed artifact from `732868` bytes to `426041` bytes while only degrading `val_bpb` from `2.61415456` to `2.62392734`. That is a small quality hit for a very large size reduction.

Collapsing all 4 logical layers onto a single shared block saved even more size, but the quality drop was noticeably larger. That suggests some repeated computation is useful, but the model still wants at least a small amount of block diversity.

Conclusion: partial layer sharing looks strong for parameter golf. `NUM_UNIQUE_BLOCKS=2` is worth keeping as an active direction, while `NUM_UNIQUE_BLOCKS=1` is probably too aggressive.
