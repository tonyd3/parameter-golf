# Loop 06 Experiment 10: PKO32 + Shared1 12-Layer Stack

## command

```bash
bash experiments/loop_06/10_pko32_shared1_layers12/run.sh
```

## hypothesis

The extreme shared-depth size frontier may become useful enough to revisit once PKO is upgraded to `32`.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp10_pko32_shared1.txt`
- `model_params:607492`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0186`
- `final_int8_zlib_roundtrip_exact val_loss:3.36971068`
- `final_int8_zlib_roundtrip_exact val_bpb:2.01895114`
- `compressed_size_bytes:645225`

## analysis

This remains interesting only as an extreme size frontier reference. `PKO32` helped somewhat, but not enough to make the shared1 regime quality-competitive.
