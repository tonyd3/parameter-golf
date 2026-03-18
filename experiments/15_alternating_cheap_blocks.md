# Experiment 15: Alternate Cheap and Full Blocks

## hypothesis

Not every layer needs the same amount of compute, so alternating cheaper blocks with full blocks may beat a uniform architecture at the same total size.

## changes

- Add block-specific MLP control to `train_gpt_mlx.py`
- Support `CHEAP_BLOCK_EVERY`, `CHEAP_BLOCK_OFFSET`, and `CHEAP_BLOCK_MLP_MULT`
- Allow `CHEAP_BLOCK_MLP_MULT=0` to remove the MLP entirely from selected blocks
- Compare against the current best non-shared 100-step recipe from experiment 13:
  - `val_bpb 2.61415456`
  - `serialized_model_int8_zlib:732868 bytes`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports alternating cheaper blocks by assigning a smaller per-block `mlp_mult`
- `exp15_alt_nomlp`
  - `CHEAP_BLOCK_EVERY=2`
  - `CHEAP_BLOCK_OFFSET=1`
  - `CHEAP_BLOCK_MLP_MULT=0`
  - `model_params:395536`
  - `final_int8_zlib_roundtrip_exact val_loss:4.39427519`
  - `final_int8_zlib_roundtrip_exact val_bpb:2.63281561`
  - `serialized_model_int8_zlib:611149 bytes`

## analysis and conclusion

Removing the MLP from every other block reduced the compressed artifact meaningfully, but the quality drop was larger than the savings justified relative to the best uniform 4-block recipe. It also underperformed the stronger size-saving idea from experiment 14, where `NUM_UNIQUE_BLOCKS=2` reached `val_bpb 2.62392734` at only `426041 bytes`.

Conclusion: alternating no-MLP blocks is a workable compression knob, but partial layer sharing is the better direction so far.
