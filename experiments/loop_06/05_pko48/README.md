# Loop 06 Experiment 05: PKO48 Sweep

## command

```bash
bash experiments/loop_06/05_pko48/run.sh
```

## hypothesis

The PKO sweet spot may still be above `32`.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp05_pko48.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9654`
- `final_int8_zlib_roundtrip_exact val_loss:3.28088880`
- `final_int8_zlib_roundtrip_exact val_bpb:1.96573380`
- `compressed_size_bytes:1106232`

## analysis

The upward PKO trend did not continue here. `48` was slightly worse than `32`, so `PKO32` now looks like the best setting among the tested PKO widths.
