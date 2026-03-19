# Loop 04 Experiment 06: MTP 2 On Best Stack

## command

```bash
bash experiments/loop_04/06_mtp2_best/run.sh
```

## hypothesis

Multi-token prediction may have failed earlier because the base stack was weaker. Re-testing `MTP_TOKENS=2` on the current best stack could uncover a stronger training objective regime.

## results / data

- `status:completed`
- `comparison_target:loop04_exp05_partialkey16`
- `log_path:logs/loop04_exp06_mtp2.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.9249`
- `pre_quant_val_bpb:2.3516`
- `final_int8_zlib_roundtrip_exact val_loss:3.92557883`
- `final_int8_zlib_roundtrip_exact val_bpb:2.35199772`
- `compressed_size_bytes:1098861`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was not supported. `MTP_TOKENS=2` failed again, and this time on the strongest current stack. The final exact proxy score of `2.35199772` is dramatically worse than the current moonshot frontier at `1.99532927`.

This strongly suggests multi-token prediction is not a good fit for the local MLX path as currently implemented. It should be deprioritized until there is a materially different implementation idea.
