# Experiment 02: Increase MLP Mult to 2

## hypothesis

Increasing `MLP_MULT` from `1` to `2` will improve `val_bpb` because the current local baseline may be bottlenecked more by feed-forward capacity than by attention capacity.

## changes

- Start from `mlx_local_v2`
- Set `MLP_MULT=2`
- For fast local iteration, use `VAL_MAX_TOKENS=1048576`
- Keep all other baseline settings fixed

## experiment results

Status: Completed

- Run ID: `exp02_mlp2`
- Validation protocol: `VAL_MAX_TOKENS=1048576`
- `model_params:592144`
- `step:100/100 val_loss:4.6993 val_bpb:2.8156`
- `saved_model:2116036 bytes`
- `serialized_model_int8_zlib:980888 bytes`
- `final_int8_zlib_roundtrip_exact val_loss:4.69936132 val_bpb:2.81560697`
- Comparison proxy baseline (`mlx_local_v2_subset`): `val_bpb 2.81933844`, `serialized_model_int8_zlib 737967 bytes`
- Comparison experiment 01 (`exp01_kv1`): `val_bpb 2.80573991`, `serialized_model_int8_zlib 677455 bytes`

## analysis and conclusion

Increasing `MLP_MULT` from `1` to `2` slightly improved the local proxy result relative to the original proxy baseline, moving from `2.81933844` to `2.81560697`. That means extra feed-forward capacity is helping at least a little.

However, the improvement is small relative to the cost. Parameter count increased from `461072` to `592144`, and the compressed artifact grew from `737967` bytes to `980888` bytes. This is also clearly less efficient than experiment 01, which both improved quality more and reduced size.

Conclusion: increasing MLP width is a viable positive direction, but it is not an especially parameter-efficient one at this scale. For this local regime, reducing KV heads looks like a stronger default move than increasing MLP capacity.
