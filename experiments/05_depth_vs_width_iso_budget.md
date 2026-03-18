# Experiment 05: Depth vs Width at Similar Scale

## hypothesis

A deeper-narrower model will outperform a shallower-wider model at similar total scale because parameter-constrained models often benefit more from extra computation depth than from extra width.

## changes

- Compare a `6x96` style model against the `4x128` baseline family
- Concrete candidate used here: `NUM_LAYERS=6`, `MODEL_DIM=96`, `NUM_HEADS=3`, `NUM_KV_HEADS=1`, `MLP_MULT=1`
- Keep `TRAIN_SEQ_LEN=1024`, `TRAIN_BATCH_TOKENS=4096`, and the validation proxy fixed
- Record params, artifact size, and `val_bpb` for both

## experiment results

Status: Completed

- Run ID: `exp05_depth6_width96`
- Validation protocol: `VAL_MAX_TOKENS=1048576`
- `model_params:358962`
- `step:100/100 val_loss:4.7205 val_bpb:2.8283`
- `saved_model:1253260 bytes`
- `serialized_model_int8_zlib:581671 bytes`
- `final_int8_zlib_roundtrip_exact val_loss:4.71970987 val_bpb:2.82779874`
- Comparison proxy baseline (`mlx_local_v2_subset`): `val_bpb 2.81933844`, `serialized_model_int8_zlib 737967 bytes`
- Comparison experiment 04 (`exp04_dim160`): `val_bpb 2.77600845`, `serialized_model_int8_zlib 1109530 bytes`

## analysis and conclusion

This deeper-narrower candidate was very efficient in size terms. It reduced parameter count from `461072` to `358962` and reduced the compressed artifact from `737967` bytes to `581671` bytes.

However, the quality tradeoff was unfavorable on the local proxy. The final proxy `val_bpb` was `2.82779874`, which is worse than the proxy baseline `2.81933844`. So in this particular comparison, extra depth did not make up for the lost width.

Conclusion: in the local 100-step regime, the `6x96` deeper-narrower model is more size-efficient but not quality-efficient enough. This is evidence against the simple “more depth, less width” story for the current setup.
