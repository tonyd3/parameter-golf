# Experiment 18: Untied or Partially Tied Embeddings

## hypothesis

Tied embeddings may be constraining the model more than they help at certain scales, so untying or partially tying them could improve quality enough to justify the extra bytes.

## changes

- Extend the MLX path to support untied output heads and a tied-plus-delta output head
- Add `LM_HEAD_DELTA_RANK` for a low-rank output correction on top of the tied embedding head
- Start from the best non-shared 100-step local recipe from experiment 13:
  - tied baseline `val_bpb:2.61415456`
  - tied baseline `serialized_model_int8_zlib:732868 bytes`
- Compare:
  - untied output head: `TIE_EMBEDDINGS=0`
  - partially tied output head: `TIE_EMBEDDINGS=1`, `LM_HEAD_DELTA_RANK=32`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports untied output heads and tied heads with a learned low-rank delta
- `exp18_untied`
  - `TIE_EMBEDDINGS=0`
  - `model_params:592144`
  - `final_int8_zlib_roundtrip_exact val_loss:4.31548166`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.58560673`
  - `serialized_model_int8_zlib:839782 bytes`
- `exp18_partial32`
  - `TIE_EMBEDDINGS=1`
  - `LM_HEAD_DELTA_RANK=32`
  - `model_params:497936`
  - `final_int8_zlib_roundtrip_exact val_loss:4.36845827`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.61734749`
  - `serialized_model_int8_zlib:801248 bytes`

## analysis and conclusion

Untying the output head gave the best 100-step quality result seen so far, beating the tied baseline by a meaningful margin. The tradeoff is size: the compressed artifact grew from `732868` bytes to `839782` bytes.

The partially tied low-rank delta head did not pay off. It added bytes but slightly underperformed the tied baseline, so in this local regime it was the worst of the three embedding/head choices.

Conclusion: full untie is a real quality win, but it is a size tradeoff. The low-rank delta head is not competitive here.
