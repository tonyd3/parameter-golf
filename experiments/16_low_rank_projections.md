# Experiment 16: Add Low-Rank Projections

## hypothesis

Some of the large dense matrices are using more rank than the task needs, so low-rank factorization can save parameters while preserving most quality.

## changes

- Add `LOW_RANK_MLP_RANK` to `train_gpt_mlx.py`
- Apply low-rank factorization only to MLP matrices first
- Start from the best non-shared 100-step local recipe from experiment 13:
  - `final_int8_zlib_roundtrip_exact val_bpb:2.61415456`
  - `serialized_model_int8_zlib:732868 bytes`
- Compare `LOW_RANK_MLP_RANK=32` and `16`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports low-rank MLPs through `LOW_RANK_MLP_RANK`
- `exp16_lrm32`
  - `LOW_RANK_MLP_RANK=32`
  - `model_params:395536`
  - `final_int8_zlib_roundtrip_exact val_loss:4.42506170`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.65126125`
  - `serialized_model_int8_zlib:612012 bytes`
- `exp16_lrm16`
  - `LOW_RANK_MLP_RANK=16`
  - `model_params:362768`
  - `final_int8_zlib_roundtrip_exact val_loss:4.45860910`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.67136107`
  - `serialized_model_int8_zlib:551719 bytes`

## analysis and conclusion

Low-rank MLPs did save parameters and bytes, but both tested ranks were clearly worse than the full-rank tuned recipe. The quality hit was larger than the savings justified in this local regime, and both variants were also worse than the stronger size-saving idea from experiment 14.

Conclusion: low-rank MLPs are not the best parameter-golf direction here. If low-rank is revisited later, it probably needs a more selective placement than “all MLPs.”
