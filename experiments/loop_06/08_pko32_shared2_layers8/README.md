# Loop 06 Experiment 08: PKO32 + Shared2 8-Layer Stack

## command

```bash
bash experiments/loop_06/08_pko32_shared2_layers8/run.sh
```

## hypothesis

The more aggressive shared-depth stack may become viable once the stronger `PKO32` bias is added.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp08_pko32_shared2.txt`
- `model_params:689672`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9905`
- `final_int8_zlib_roundtrip_exact val_loss:3.32268214`
- `final_int8_zlib_roundtrip_exact val_bpb:1.99077414`
- `compressed_size_bytes:799070`

## analysis

This improved meaningfully over the earlier shared2 runs, but it still trails the shared3 variant on quality while only modestly improving size. Shared3 remains the stronger size-aware choice.
