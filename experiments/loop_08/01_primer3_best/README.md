# Loop 08 Experiment 01: PKO32 + AltCheap8 + Value + Primer Depthwise Conv k=3

## command

```bash
bash experiments/loop_08/01_primer3_best/run.sh
```

## hypothesis

Primer-style causal depthwise conv in q/k/v should improve local pattern extraction on top of the current best stack without requiring a wider model.

## results / data

- `status:completed`
- `comparison_target:loop06_exp09_pko32_altcheap8_value`
- `log_path:logs/loop08_exp01_primer3_best.txt`
- `model_params:1190432`
- `steps_reached:600/600`
- `pre_quant_val_bpb:1.9135`
- `final_int8_zlib_roundtrip_exact val_loss:3.19415760`
- `final_int8_zlib_roundtrip_exact val_bpb:1.91376908`
- `compressed_size_bytes:1606031`

## analysis

Supported. Primer k=3 clearly beat the prior frontier and improved quality with only a modest size increase, so direct local bias inside attention looks like a real lever in this repo.
