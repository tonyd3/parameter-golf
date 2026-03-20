# Loop 09 Experiment 10: Persistent Memory 16 Without Bigram Hash

## command

```bash
bash experiments/loop_09/10_pmem16_no_bigram/run.sh
```

## hypothesis

If persistent memory absorbs enough lexical/statistical structure, the explicit bigram hash path may no longer be necessary.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp10_pmem16_no_bigram.txt`
- `model_params:954912`
- `steps_reached:600`
- `pre_quant_val_bpb:1.9273`
- `final_int8_zlib_roundtrip_exact val_loss:3.21730542`
- `final_int8_zlib_roundtrip_exact val_bpb:1.92763803`
- `compressed_size_bytes:1406309`

## analysis

Removing bigram hash was clearly negative again. Persistent memory did not absorb the lexical/statistical signal that the explicit bigram path provides.
