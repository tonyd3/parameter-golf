# Loop 09 Experiment 06: Persistent Memory 16 Without Value Embedding

## command

```bash
bash experiments/loop_09/06_pmem16_no_value/run.sh
```

## hypothesis

Persistent memory may make the extra value embedding redundant, allowing a cleaner stack with similar or better quality.

## results / data

- `status:completed`
- `comparison_target:loop08_exp05_persistent_memory16_best`
- `log_path:logs/loop09_exp06_pmem16_no_value.txt`
- `model_params:1085984`
- `steps_reached:600`
- `pre_quant_val_bpb:1.9277`
- `final_int8_zlib_roundtrip_exact val_loss:3.21784639`
- `final_int8_zlib_roundtrip_exact val_bpb:1.92796215`
- `compressed_size_bytes:1539184`

## analysis

Removing value embeddings was clearly bad. Persistent memory did not replace the value path successfully in this stack.
