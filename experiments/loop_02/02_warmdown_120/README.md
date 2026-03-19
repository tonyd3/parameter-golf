# Loop 02 Experiment 02: Warmdown 120

## command

```bash
bash experiments/loop_02/02_warmdown_120/run.sh
```

## hypothesis

The best local stack now runs long enough that the cooldown matters more. Increasing `WARMDOWN_ITERS` from `60` to `120` should improve the final proxy score. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp01_anchor600`
- `log_path:experiments/loop_02/02_warmdown_120/logs/loop02_exp02_warmdown120.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.6040`
- `pre_quant_val_bpb:2.1593`
- `final_int8_zlib_roundtrip_exact val_loss:3.60413408`
- `final_int8_zlib_roundtrip_exact val_bpb:2.15940515`
- `compressed_size_bytes:1046216`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was supported. Extending `WARMDOWN_ITERS` from `60` to `120` improved the local proxy result from `2.18845266` to `2.15940515`, a gain of about `0.0290 val_bpb`. The artifact grew slightly from `1043961` bytes to `1046216` bytes, but the quality improvement is much larger than the size cost.

This is now the best local MLX proxy result in the repo. The result suggests the longer `600`-step loop wants a smoother exit than the old `300`-step stack did.
