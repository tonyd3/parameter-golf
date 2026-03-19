# Loop 03 Experiment 03: 900 Iterations On The Best Stack

## command

```bash
bash experiments/loop_03/03_iters900_best_stack/run.sh
```

## hypothesis

Every major local step-scaling experiment so far has been positive, and the current best stack still trains very quickly. Increasing `ITERATIONS` from `600` to `900` should improve `loop03_exp02_batch16384_noclip_warmdown120`.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop03_exp03_iters900_best.txt`
- `model_params:854288`
- `steps_reached:900/900`
- `pre_quant_val_loss:3.3571`
- `pre_quant_val_bpb:2.0114`
- `final_int8_zlib_roundtrip_exact val_loss:3.35767007`
- `final_int8_zlib_roundtrip_exact val_bpb:2.01173704`
- `compressed_size_bytes:1104197`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was supported. Scaling the current best stack from `600` to `900` iterations improved the final exact proxy score from `2.06218386` to `2.01173704`, a gain of about `0.0504 val_bpb`, while the compressed size stayed essentially flat.

This is now the strongest local proxy result in the repo. The main conclusion is that the current local stack is still undertrained, so iteration count remains the highest-confidence next lever.
