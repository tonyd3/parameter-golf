# Loop 05 Experiment 03: PKO8 Sweep

## command

```bash
bash experiments/loop_05/03_pko08/run.sh
```

## hypothesis

The `16`-dim partial key offset may be larger than necessary, and a smaller offset could improve quality by acting as a gentler bias.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp03_pko08.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0692`
- `final_int8_zlib_roundtrip_exact val_loss:3.45389485`
- `final_int8_zlib_roundtrip_exact val_bpb:2.06938981`
- `compressed_size_bytes:1104113`

## analysis

Reducing PKO from `16` to `8` was a clear regression. That strongly suggests the prior `16`-dim setting was not accidentally oversized and should remain the default PKO value for now.
