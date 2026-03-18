# Experiment 12: Sweep Sequence Length and RoPE Base

## hypothesis

Changing `TRAIN_SEQ_LEN` and `ROPE_BASE` together will alter the byte span seen per step and the way rotary positions are extrapolated, which may improve compression performance on held-out text.

## changes

- Local approximation on the fixed 1M-token validation proxy
- Start from the best non-shared 100-step local recipe from experiment 13
- Use experiment 13 as the comparison point:
  - `TRAIN_SEQ_LEN=1024`
  - `ROPE_BASE=10000`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.61415456`
- Compare:
  - `TRAIN_SEQ_LEN=512`, `ROPE_BASE=10000`
  - `TRAIN_SEQ_LEN=1024`, `ROPE_BASE=50000`
  - `TRAIN_SEQ_LEN=2048`, `ROPE_BASE=50000`

## experiment results

- `exp12_seq512_rope10k`
  - `TRAIN_SEQ_LEN=512`
  - `ROPE_BASE=10000`
  - `final_int8_zlib_roundtrip_exact val_loss:4.32873964`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.59355021`
  - `serialized_model_int8_zlib:732791 bytes`
- `exp12_seq1024_rope50k`
  - `TRAIN_SEQ_LEN=1024`
  - `ROPE_BASE=50000`
  - `final_int8_zlib_roundtrip_exact val_loss:4.39755201`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.63477891`
  - `serialized_model_int8_zlib:732873 bytes`
- `exp12_seq2048_rope50k`
  - `TRAIN_SEQ_LEN=2048`
  - `ROPE_BASE=50000`
  - `final_int8_zlib_roundtrip_exact val_loss:4.43772221`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.65884675`
  - `serialized_model_int8_zlib:732766 bytes`

## analysis and conclusion

On this local proxy, shorter sequences were clearly better and the larger RoPE base was clearly worse. `TRAIN_SEQ_LEN=512` with the baseline `ROPE_BASE=10000` improved the tuned 100-step recipe from `2.61415456` to `2.59355021`, while both `ROPE_BASE=50000` variants regressed.

Conclusion: for local iteration, `TRAIN_SEQ_LEN=512` is a strong direction and the larger RoPE base is not.
