# Loop 06 Experiment 01: PKO32 + Alternating Cheap 8-Layer Stack

## command

```bash
bash experiments/loop_06/01_pko32_altcheap8/run.sh
```

## hypothesis

The best `PKO16` quality compound may improve again when upgraded to `PKO32`.

## results / data

- `status:completed`
- `comparison_target:loop05_exp04_pko32`
- `log_path:logs/loop06_exp01_pko32_altcheap8.txt`
- `model_params:1053216`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9453`
- `final_int8_zlib_roundtrip_exact val_loss:3.24709058`
- `final_int8_zlib_roundtrip_exact val_bpb:1.94548370`
- `compressed_size_bytes:1479360`

## analysis

This is a strong frontier improvement over the `PKO32` base run. The best depth compound from `PKO16` transferred cleanly to `PKO32` and remains one of the strongest overall quality candidates despite its size cost.
