# Loop 03 Experiment 02: Batch 16384 + No Clip + Warmdown 120

## command

```bash
bash experiments/loop_03/02_batch16384_noclip_warmdown120/run.sh
```

## hypothesis

`WARMDOWN_ITERS=120` was independently positive in `loop_02`, and `batch16384 + no_clip` is the new local frontier. Combining all three should beat `loop03_pilot_batch16384_noclip`.

## results / data

- `status:completed`
- `comparison_target:loop03_pilot_batch16384_noclip`
- `log_path:logs/loop03_exp02_batch16384_noclip_warmdown120.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.4413`
- `pre_quant_val_bpb:2.0619`
- `final_int8_zlib_roundtrip_exact val_loss:3.44186783`
- `final_int8_zlib_roundtrip_exact val_bpb:2.06218386`
- `compressed_size_bytes:1105923`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was supported. Extending `WARMDOWN_ITERS` from `60` to `120` on top of the `batch16384 + no_clip` stack improved the final exact score from `2.07760213` to `2.06218386`, a gain of about `0.0154 val_bpb`. The compressed artifact grew only slightly from `1104375` bytes to `1105923` bytes.

This is now the best completed local proxy result. The next most likely win is more training time, because every previous step-scaling experiment has been positive on the local proxy.
