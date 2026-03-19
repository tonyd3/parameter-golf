# Loop 02 Experiment 01: Anchor 600

## command

```bash
bash experiments/loop_02/01_anchor_600/run.sh
```

## hypothesis

The strongest local proxy stack from the previous phase should continue improving when extended from `300` to `600` steps. Comparison target: `exp37_warmup40`.

## results / data

- `status:completed`
- `comparison_target:exp37_warmup40`
- `log_path:experiments/loop_02/01_anchor_600/logs/loop02_exp01_anchor600.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.6525`
- `pre_quant_val_bpb:2.1884`
- `final_int8_zlib_roundtrip_exact val_loss:3.65261555`
- `final_int8_zlib_roundtrip_exact val_bpb:2.18845266`
- `compressed_size_bytes:1043961`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was supported. Extending the strongest previous local proxy stack from `300` to `600` steps improved the final exact proxy score from `2.25032972` in `exp37_warmup40` to `2.18845266`, while also shrinking the compressed artifact slightly from `1055794` bytes to `1043961` bytes.

This is now the strongest local MLX proxy result in the repo and should become the default comparison point for the rest of `loop_02`. The next priority is not a large architecture change; it is a controlled refinement of this stack, starting with cooldown length and the contribution of the bigram feature.
