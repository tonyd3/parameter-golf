# Loop 04 Experiment 08: Low-Rank 32 Wider 160-Dim Stack

## command

```bash
bash experiments/loop_04/08_lowrank32_dim160/run.sh
```

## hypothesis

A wider `160`-dim model with low-rank MLPs may buy a different quality-per-byte tradeoff than the current `128`-dim dense stack.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp08_lowrank32_dim160.txt`
- `model_params:1047376`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0682`
- `final_int8_zlib_roundtrip_exact val_loss:3.45235658`
- `final_int8_zlib_roundtrip_exact val_bpb:2.06846816`
- `compressed_size_bytes:1340030`

## analysis

This was slightly worse than the fixed-`600` anchor and materially larger after compression. The wider low-rank MLP idea did not recover enough quality to justify the extra bytes, so this direction looks dominated by both the plain anchor and the better moonshot variants.
