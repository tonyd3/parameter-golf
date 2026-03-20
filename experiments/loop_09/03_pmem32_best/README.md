# Loop 09 Experiment 03: Persistent Memory 32

## command

```bash
bash experiments/loop_09/03_pmem32_best/run.sh
```

## hypothesis

The memory sweep may continue to improve beyond 24 if the current stack still under-allocates persistent memory.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp03_pmem32_best.txt`
- `model_params:1249824`
- `steps_reached:600`
- `pre_quant_val_bpb:1.9060`
- `final_int8_zlib_roundtrip_exact val_loss:3.18169951`
- `final_int8_zlib_roundtrip_exact val_bpb:1.90630486`
- `compressed_size_bytes:1717935`

## analysis

`32` memory slots lost most of the gain from `24`, so the sweep appears to peak around `24` rather than improving monotonically with more memory.
