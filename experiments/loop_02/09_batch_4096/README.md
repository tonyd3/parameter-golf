# Loop 02 Experiment 09: Batch 4096

## command

```bash
bash experiments/loop_02/09_batch_4096/run.sh
```

## hypothesis

At `600` local steps, a smaller token batch may improve learning efficiency per update enough to beat the default `8192`-token batch. Comparison target: `loop02_exp01_anchor600`.

## results / data

- `status:completed`
- `comparison_target:loop02_exp05_noclip`
- `log_path:logs/loop02_exp09_batch4096.txt`
- `model_params:854288`
- `steps_reached:600/600`
- `pre_quant_val_loss:3.8384`
- `pre_quant_val_bpb:2.2998`
- `final_int8_zlib_roundtrip_exact val_loss:3.83869529`
- `final_int8_zlib_roundtrip_exact val_bpb:2.29994173`
- `compressed_size_bytes:1043356`
- `saved_model_bytes:2640770`

## analysis

The hypothesis was not supported. Halving the token batch from `8192` to `4096` made step time much faster, but the quality regression was large: `2.29994173` versus the current anchor at `2.14198973`.

This is a good example of why raw throughput is not the objective. The smaller batch improved wallclock efficiency but hurt optimization enough that the final quality was much worse. `TRAIN_BATCH_TOKENS=4096` should be rejected for this local stack.
