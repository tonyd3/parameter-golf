# Experiment 06: Increase Iterations to 300

## hypothesis

The current local baseline may simply be undertrained, so increasing `ITERATIONS` from `100` to `300` may improve `val_bpb` without any architectural change.

## changes

- Start from `mlx_local_v2`
- Set `ITERATIONS=300`
- Keep all architecture settings fixed
- For fast local iteration, use `VAL_MAX_TOKENS=1048576`

## experiment results

Status: Completed

- Run ID: `exp06_iters300`
- Validation protocol: `VAL_MAX_TOKENS=1048576`
- `model_params:461072`
- `step:300/300 val_loss:4.3069 val_bpb:2.5805`
- `saved_model:1591748 bytes`
- `serialized_model_int8_zlib:742981 bytes`
- `final_int8_zlib_roundtrip_exact val_loss:4.30829763 val_bpb:2.58130244`
- Comparison proxy baseline (`mlx_local_v2_subset`): `val_bpb 2.81933844`, `serialized_model_int8_zlib 737967 bytes`
- Comparison experiment 04 (`exp04_dim160`): `val_bpb 2.77600845`, `serialized_model_int8_zlib 1109530 bytes`

## analysis and conclusion

This was the biggest win so far, and it came entirely from training longer. Keeping the architecture fixed and increasing `ITERATIONS` from `100` to `300` improved the final proxy `val_bpb` from `2.81933844` to `2.58130244`.

The artifact size barely changed, moving from `737967` bytes on the proxy baseline to `742981` bytes here. That means this improvement is almost pure optimization gain rather than a size tradeoff.

Conclusion: the current local baseline was heavily undertrained. Before chasing more architectural complexity, longer training should be considered a priority direction. This is the strongest result in the experiment set so far.
