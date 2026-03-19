# Loop 01 Experiment 10: Bigram 2048 on Best Schedule

## command

```bash
bash experiments/loop_01/10_bigram2048_best_sched/run.sh
```

## hypothesis

Bigram hash embeddings helped strongly in local MLX runs but were bundled with too many losing changes in the first remote attempt. Re-testing `BIGRAM_HASH_VOCAB=2048` on top of the best remote schedule, while keeping `KV4` and tied embeddings, may recover that local win in a controlled way. Comparison target: `exp43_1gpu_seqwarm150_minlr01`.

## results / data

- `status:not_run_yet`
- `comparison_target:exp43_1gpu_seqwarm150_minlr01`
- `log_path:pending`
- `model_params:pending`
- `steps_reached:pending`
- `pre_quant_val_bpb:pending`
- `final_int8_zlib_roundtrip_exact val_bpb:pending`
- `compressed_size_bytes:pending`

## analysis

Pending run. This is the only wildcard in the loop and should be judged strictly against both score and compressed size.
