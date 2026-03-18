# Experiment 24: Size-Aware Shared Stack

## hypothesis

The strongest size-saving direction, partial layer sharing, may recover some lost quality when combined with the best local optimization knobs.

## changes

- Start from `NUM_UNIQUE_BLOCKS=2`
- Add the strongest non-architectural local improvements discovered so far
- Compare against both the shared baseline and the best non-shared recipe

## experiment results

- Comparison point
  - experiment 14 shared baseline: `val_bpb 2.62392734`, `426041 bytes`
- `exp24_share2_seq512_clip05`
  - `NUM_UNIQUE_BLOCKS=2`
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - `model_params:296200`
  - `final_int8_zlib_roundtrip_exact val_loss:4.31279087`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.58399455`
  - `serialized_model_int8_zlib:422473 bytes`

## analysis and conclusion

The shared model benefited a lot from the stronger local optimization stack. It improved sharply over the original shared baseline while keeping the artifact extremely small. The compressed model stayed around `422 KB`, which is dramatically smaller than the best non-shared quality stack.

Conclusion: this is the best local size-aware recipe so far. It is much smaller than the non-shared models while staying competitive on quality.
