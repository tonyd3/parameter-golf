# Loop 03 Experiment 04: 1200 Iterations On The Best Stack

## command

```bash
bash experiments/loop_03/04_iters1200_best_stack/run.sh
```

## hypothesis

Step scaling is still strongly positive on the current local best recipe. Increasing `ITERATIONS` from `900` to `1200` should improve `loop03_exp03_iters900_best`.

## results / data

- `status:completed`
- `comparison_target:loop03_exp03_iters900_best`
- `log_path:logs/loop03_exp04_iters1200_best.txt`
- `model_params:854288`
- `steps_reached:1200/1200`
- `pre_quant_val_loss:3.3271`
- `pre_quant_val_bpb:1.9934`
- `final_int8_zlib_roundtrip_exact val_loss:3.32789326`
- `final_int8_zlib_roundtrip_exact val_bpb:1.99389637`
- `compressed_size_bytes:1105964`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was supported. Scaling the current best stack from `900` to `1200` iterations improved the final exact proxy score from `2.01173704` to `1.99389637`, a gain of about `0.0178 val_bpb`. The compressed size remained effectively flat.

This is now the strongest local proxy result in the repo. The pattern from `300 -> 600 -> 900 -> 1200` is consistent enough that iteration count should remain the first-class optimization lever in the next local loop.
