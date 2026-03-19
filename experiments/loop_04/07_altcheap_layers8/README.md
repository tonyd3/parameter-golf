# Loop 04 Experiment 07: Alternating Cheap 8-Layer Stack

## command

```bash
bash experiments/loop_04/07_altcheap_layers8/run.sh
```

## hypothesis

Extra logical depth with every other block made cheap may outperform the plain 4-layer stack while keeping the model smaller than a full 8-layer architecture.

## results / data

- `status:completed`
- `comparison_target:loop03_exp02_batch16384_noclip_warmdown120`
- `log_path:logs/loop04_exp07_altcheap8.txt`
- `model_params:1053216`
- `steps_reached:600/600`
- `pre_quant_val_bpb:2.0483`
- `final_int8_zlib_roundtrip_exact val_loss:3.41909862`
- `final_int8_zlib_roundtrip_exact val_bpb:2.04854176`
- `compressed_size_bytes:1477865`

## analysis

This was a real quality win over the fixed-`600` anchor (`2.06218386`), which means extra logical depth with alternating cheap blocks does have signal on the stronger stack. It did not beat `loop04_exp05_partialkey16`, and it paid a substantial byte cost, so the current read is that alternating cheap blocks are a viable moonshot quality direction but not the new frontier.
