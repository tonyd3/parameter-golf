# Experiment 37: Sweep Warmup Steps On The Best Local Stack

## hypothesis

Because MLX warmup only primes compile and allocation paths rather than updating weights, changing `WARMUP_STEPS` on the best local stack should have at most a small effect on final quality. If there is an effect, a moderate warmup may slightly help by stabilizing the compiled path before measured training starts.

## changes

- Start from experiment 36
- Keep the same 1M-token validation proxy
- Vary only `WARMUP_STEPS` across `0`, `20`, `40`, and `100`

## experiment results

- Baseline comparison point
  - experiment 36: `val_bpb 2.25200604`
- `exp37_warmup0`
  - `WARMUP_STEPS=0`
  - `final_int8_zlib_roundtrip_exact val_loss:3.75829315`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.25176906`
  - `serialized_model_int8_zlib:1055619 bytes`
- `exp37_warmup20`
  - `WARMUP_STEPS=20`
  - `final_int8_zlib_roundtrip_exact val_loss:3.75676155`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.25085140`
  - `serialized_model_int8_zlib:1055782 bytes`
- `exp37_warmup40`
  - `WARMUP_STEPS=40`
  - `final_int8_zlib_roundtrip_exact val_loss:3.75589085`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.25032972`
  - `serialized_model_int8_zlib:1055794 bytes`
- `exp37_warmup100`
  - `WARMUP_STEPS=100`
  - `final_int8_zlib_roundtrip_exact val_loss:3.75638580`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.25062627`
  - `serialized_model_int8_zlib:1055361 bytes`

## analysis and conclusion

The effect size was very small. `WARMUP_STEPS=40` was the best of the four, but all runs landed in a very tight band around `2.2503` to `2.2518`.

That matches the implementation in `train_gpt_mlx.py`: warmup materializes loss and gradients to prime MLX compile/allocation paths, resets the loader, and does not update model weights. In other words, this warmup is mostly a systems knob, not a learning knob.

Conclusion: for the local MLX proxy, warmup step count is low leverage. If we want the best number from this sweep, use `WARMUP_STEPS=40`, but it should not be treated as a major source of gain.
