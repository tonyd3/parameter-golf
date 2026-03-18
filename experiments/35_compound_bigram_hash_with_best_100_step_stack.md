# Experiment 35: Compound Bigram Hash With The Best 100-Step Quality Stack

## hypothesis

The bigram-hash port and the untied-head optimization stack attack different bottlenecks, so they should compound rather than overlap.

## changes

- Start from experiment 22:
  - `TRAIN_SEQ_LEN=512`
  - `POST_STEP_WEIGHT_CLIP=0.5`
  - `TIE_EMBEDDINGS=0`
- Add `BIGRAM_HASH_VOCAB`
- Keep the 1M-token validation proxy fixed

## experiment results

- Comparison points
  - experiment 22 untied stack: `val_bpb 2.53943806`, `827611 bytes`
  - experiment 26 tied bigram-hash stack: `val_bpb 2.47139713`, `958431 bytes`
- `exp35_bigram2048_seq512_clip05_untied`
  - `BIGRAM_HASH_VOCAB=2048`
  - `model_params:854288`
  - `final_int8_zlib_roundtrip_exact val_loss:4.03527069`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.41771924`
  - `serialized_model_int8_zlib:1054158 bytes`

## analysis and conclusion

The bigram-hash port compounded cleanly with the untied-head quality stack. That means the two changes are not just solving the same bottleneck; the extra local transition feature is still useful even after strengthening the output head and optimization recipe.

Conclusion: this is the best 100-step local result so far and a strong candidate for longer runs.
