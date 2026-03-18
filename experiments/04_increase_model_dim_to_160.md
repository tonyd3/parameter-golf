# Experiment 04: Increase Model Dim to 160

## hypothesis

Increasing `MODEL_DIM` from `128` to `160` will improve quality because the current local baseline may be width-limited in its hidden representation.

## changes

- Start from `mlx_local_v2`
- Set `MODEL_DIM=160`
- Keep `NUM_HEADS=4` and `NUM_KV_HEADS=2`
- For fast local iteration, use `VAL_MAX_TOKENS=1048576`

## experiment results

Status: Completed

- Run ID: `exp04_dim160`
- Validation protocol: `VAL_MAX_TOKENS=1048576`
- `model_params:678736`
- `step:100/100 val_loss:4.6333 val_bpb:2.7760`
- `saved_model:2396868 bytes`
- `serialized_model_int8_zlib:1109530 bytes`
- `final_int8_zlib_roundtrip_exact val_loss:4.63326979 val_bpb:2.77600845`
- Comparison proxy baseline (`mlx_local_v2_subset`): `val_bpb 2.81933844`, `serialized_model_int8_zlib 737967 bytes`
- Comparison experiment 01 (`exp01_kv1`): `val_bpb 2.80573991`, `serialized_model_int8_zlib 677455 bytes`

## analysis and conclusion

Increasing width from `MODEL_DIM=128` to `160` produced the best local proxy score so far. The final proxy `val_bpb` improved from `2.81933844` on the proxy baseline to `2.77600845`, which is a meaningfully larger improvement than experiments 01 or 02.

The downside is size. Parameter count rose from `461072` to `678736`, and the compressed artifact grew from `737967` bytes to `1109530` bytes. So this is not the most byte-efficient win, but it is the strongest raw quality win on the current local proxy.

Conclusion: width is a strong direction in this local regime. If we care most about improving `val_bpb`, `MODEL_DIM=160` is the best result so far. If we care more about parameter efficiency, experiment 01 remains more attractive.
