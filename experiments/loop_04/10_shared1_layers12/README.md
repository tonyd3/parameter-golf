# Loop 04 Experiment 10: Shared 1-of-12 Stack

## command

```bash
bash experiments/loop_04/10_shared1_layers12/run.sh
```

## hypothesis

An extreme shared/recurrent stack with one unique block repeated across many logical layers might discover a radically different compute-heavy, weight-light regime that wins on the fixed 600-step proxy.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp10_shared1_layers12.txt`
- `model_params:607492`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.1052`
- `final_int8_zlib_roundtrip_exact val_loss:3.51443815`
- `final_int8_zlib_roundtrip_exact val_bpb:2.10566413`
- `compressed_size_bytes:646059`

## analysis

The extreme recurrent/shared stack was clearly worse on quality, but it produced the smallest compressed artifact in the entire moonshot loop. That makes it interesting as a size frontier reference, but not as a direct quality candidate.
