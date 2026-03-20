# Loop 09 Experiment 07: Persistent Memory 16 + Shared3 Layers12

## command

```bash
bash experiments/loop_09/07_pmem16_shared3/run.sh
```

## hypothesis

A larger memory bank may repair more of the quality loss in the best shared-depth size-aware regime.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp07_pmem16_shared3.txt`
- `model_params:784652`
- `steps_reached:600`
- `pre_quant_val_bpb:1.9485`
- `final_int8_zlib_roundtrip_exact val_loss:3.25301266`
- `final_int8_zlib_roundtrip_exact val_bpb:1.94903190`
- `compressed_size_bytes:975626`

## analysis

The shared-depth hybrid remains attractive for bytes, but it is still well behind the main quality frontier. Persistent memory helped less here than in the full-depth stack.
