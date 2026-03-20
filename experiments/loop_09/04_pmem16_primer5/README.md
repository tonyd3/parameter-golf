# Loop 09 Experiment 04: Persistent Memory 16 + Primer k=5

## command

```bash
bash experiments/loop_09/04_pmem16_primer5/run.sh
```

## hypothesis

Persistent memory and Primer-style local bias may be complementary because one adds learned memory slots while the other improves local token mixing inside attention.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp04_pmem16_primer5.txt`
- `model_params:1227296`
- `steps_reached:600`
- `pre_quant_val_bpb:1.8950`
- `final_int8_zlib_roundtrip_exact val_loss:3.16321230`
- `final_int8_zlib_roundtrip_exact val_bpb:1.89522831`
- `compressed_size_bytes:1676633`

## analysis

Persistent memory and Primer compounded well. This beat both the anchor and `pmem24` alone, so the attention-locality bias is complementary rather than redundant.
