# Loop 09 Experiment 09: Persistent Memory 16 + Talking-Heads

## command

```bash
bash experiments/loop_09/09_pmem16_talking_heads/run.sh
```

## hypothesis

Head mixing may compound with persistent memory if better inter-head coordination helps the model use memory slots more effectively.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp09_pmem16_talking_heads.txt`
- `model_params:1217312`
- `steps_reached:600`
- `pre_quant_val_bpb:1.8920`
- `final_int8_zlib_roundtrip_exact val_loss:3.15811539`
- `final_int8_zlib_roundtrip_exact val_bpb:1.89217451`
- `compressed_size_bytes:1656443`

## analysis

Talking-heads was a real quality win and landed just behind `pmem24 + primer5`. The problem is runtime: step time exploded to roughly `500ms`, so this is a poor practical default on the MLX path despite the quality gain.
