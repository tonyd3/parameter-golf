# Experiment 01: Reduce KV Heads to 1

## hypothesis

Reducing `NUM_KV_HEADS` from `2` to `1` will preserve most of the local baseline quality while reducing attention parameter cost and artifact size, which is attractive in a byte-limited challenge.

## changes

- Start from `mlx_local_v2`
- Set `NUM_KV_HEADS=1`
- For fast local iteration, use `VAL_MAX_TOKENS=1048576`
- Keep all other baseline settings fixed

## experiment results

Status: Completed

- Run ID: `exp01_kv1`
- Validation protocol: `VAL_MAX_TOKENS=1048576`
- `model_params:428304`
- `step:100/100 val_loss:4.6822 val_bpb:2.8053`
- `saved_model:1460676 bytes`
- `serialized_model_int8_zlib:677455 bytes`
- `final_int8_zlib_roundtrip_exact val_loss:4.68289280 val_bpb:2.80573991`
- Comparison proxy baseline (`mlx_local_v2_subset`): `val_bpb 2.81933844`, `serialized_model_int8_zlib 737967 bytes`

## analysis and conclusion

This experiment improved the local proxy result while also shrinking the model. Moving from `NUM_KV_HEADS=2` to `NUM_KV_HEADS=1` reduced parameter count from `461072` to `428304` and reduced the compressed artifact from `737967` bytes to `677455` bytes. At the same time, the final proxy `val_bpb` improved from `2.81933844` to `2.80573991`.

Conclusion: this is a clear positive direction. On the local proxy, one KV head appears strictly better than two KV heads for this model size. This should be promoted into future local baselines and later verified on fuller evaluation or remote runs.
