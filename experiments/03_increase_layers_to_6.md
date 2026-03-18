# Experiment 03: Increase Layers to 6

## hypothesis

Increasing `NUM_LAYERS` from `4` to `6` will improve quality more efficiently than widening the model because extra depth may buy more representational reuse per parameter.

## changes

- Start from `mlx_local_v2`
- Set `NUM_LAYERS=6`
- For fast local iteration, use `VAL_MAX_TOKENS=1048576`
- Keep all other baseline settings fixed

## experiment results

Status: Completed

- Run ID: `exp03_layers6`
- Validation protocol: `VAL_MAX_TOKENS=1048576`
- `model_params:626072`
- `step:100/100 val_loss:4.7229 val_bpb:2.8297`
- `saved_model:2256324 bytes`
- `serialized_model_int8_zlib:1046265 bytes`
- `final_int8_zlib_roundtrip_exact val_loss:4.72328568 val_bpb:2.82994117`
- Comparison proxy baseline (`mlx_local_v2_subset`): `val_bpb 2.81933844`, `serialized_model_int8_zlib 737967 bytes`

## analysis and conclusion

Increasing depth from `4` to `6` layers was not helpful in this local regime. The model became substantially larger, growing from `461072` to `626072` parameters and from `737967` bytes to `1046265` bytes in compressed artifact size, but the final proxy `val_bpb` got worse: `2.82994117` compared with the proxy baseline `2.81933844`.

This indicates that simply adding depth is not automatically a win under a short training budget. The deeper model may need either more iterations, different optimization settings, or a different width/depth balance to pay off.

Conclusion: `NUM_LAYERS=6` is a negative result relative to the current local baseline. For now, depth alone should not be promoted into the local default.
