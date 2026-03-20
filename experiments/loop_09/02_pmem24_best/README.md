# Loop 09 Experiment 02: Persistent Memory 24

## command

```bash
bash experiments/loop_09/02_pmem24_best/run.sh
```

## hypothesis

If 16 memory slots helped because the model is memory-capacity limited, 24 slots may improve further before diminishing returns set in.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp02_pmem24_best.txt`
- `model_params:1233440`
- `steps_reached:600`
- `pre_quant_val_bpb:1.9009`
- `final_int8_zlib_roundtrip_exact val_loss:3.17301726`
- `final_int8_zlib_roundtrip_exact val_bpb:1.90110292`
- `compressed_size_bytes:1687560`

## analysis

Increasing persistent memory from `16` to `24` helped. This is a real quality win over the anchor at a modest byte cost, which suggests the memory sweep had not yet peaked at `16`.
