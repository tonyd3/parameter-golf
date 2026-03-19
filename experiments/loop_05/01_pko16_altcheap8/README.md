# Loop 05 Experiment 01: PKO16 + Alternating Cheap 8-Layer Stack

## command

```bash
bash experiments/loop_05/01_pko16_altcheap8/run.sh
```

## hypothesis

The strongest attention-side moonshot and the strongest extra-depth moonshot may compound into a better quality result than either one alone.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop05_exp01_pko16_altcheap8.txt`
- `model_params:1053216`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9700`
- `final_int8_zlib_roundtrip_exact val_loss:3.28839946`
- `final_int8_zlib_roundtrip_exact val_bpb:1.97023378`
- `compressed_size_bytes:1476051`

## analysis

This is the new best fixed-`600` local result. The compound of PKO16 and alternating cheap depth clearly worked better than either ingredient alone, though it pays a noticeable size cost. Right now this is the strongest local quality frontier.
