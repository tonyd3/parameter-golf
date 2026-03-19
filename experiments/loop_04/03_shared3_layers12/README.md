# Loop 04 Experiment 03: Shared 3-of-12 Stack

## command

```bash
bash experiments/loop_04/03_shared3_layers12/run.sh
```

## hypothesis

A less aggressive shared stack using `3` unique blocks across `12` logical layers may outperform the 2-of-8 variant while preserving the weight-light strategy.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp03_shared3_layers12.txt`
- `model_params:772364`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.4536`
- `pre_quant_val_bpb:2.0692`
- `final_int8_zlib_roundtrip_exact val_loss:3.45418406`
- `final_int8_zlib_roundtrip_exact val_bpb:2.06956308`
- `compressed_size_bytes:953739`
- `saved_model_bytes:2310786`

## analysis

The hypothesis was not supported as a raw quality win. The `3-of-12` shared stack regressed slightly from `2.06218386` to `2.06956308`.

However, it is still a strong size-efficiency result. The compressed artifact dropped to `953739` bytes, which is much smaller than the best full-quality stack. So the shared-depth family remains interesting when bytes matter more than the absolute best local proxy score.
