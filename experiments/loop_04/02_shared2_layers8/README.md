# Loop 04 Experiment 02: Shared 2-of-8 Stack

## command

```bash
bash experiments/loop_04/02_shared2_layers8/run.sh
```

## hypothesis

Reusing `2` unique blocks across `8` logical layers may let the model spend more compute depth without paying for more unique parameters, beating the 4-layer anchor.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp02_shared2_layers8.txt`
- `model_params:689672`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.4766`
- `pre_quant_val_bpb:2.0830`
- `final_int8_zlib_roundtrip_exact val_loss:3.47725558`
- `final_int8_zlib_roundtrip_exact val_bpb:2.08338631`
- `compressed_size_bytes:798448`
- `saved_model_bytes:1977730`

## analysis

The hypothesis was not supported on pure quality. The shared `2-of-8` stack regressed slightly from `2.06218386` to `2.08338631`.

But it is still a meaningful size result. The compressed artifact fell sharply from `1105923` bytes to `798448` bytes. So this is not a dead idea; it is a quality/size tradeoff candidate rather than a new quality frontier.
