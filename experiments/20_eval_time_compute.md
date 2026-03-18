# Experiment 20: Add Evaluation-Time Compute

## hypothesis

Parameter golf may reward extra compute at evaluation time more than standard LM training does, because stored weights are byte-limited but evaluation is allowed to be more aggressive.

## changes

- Add `EVAL_EXTRA_PASSES` to `train_gpt_mlx.py`
- Keep training unchanged, but reuse the decoder stack for extra passes during evaluation only
- Start from the best non-shared 100-step local recipe from experiment 13:
  - post-quant exact `val_bpb:2.61415456`
  - `eval_time:681ms`
- Compare `EVAL_EXTRA_PASSES=1` and `2`

## experiment results

- Code change
  - `train_gpt_mlx.py` now supports eval-only extra decoder passes through `EVAL_EXTRA_PASSES`
- `exp20_evalpass1`
  - `EVAL_EXTRA_PASSES=1`
  - `final_int8_zlib_roundtrip_exact val_loss:5.32597971`
  - `final_int8_zlib_roundtrip_exact val_bpb:3.19104333`
  - `eval_time:971ms`
- `exp20_evalpass2`
  - `EVAL_EXTRA_PASSES=2`
  - `final_int8_zlib_roundtrip_exact val_loss:6.14469242`
  - `final_int8_zlib_roundtrip_exact val_bpb:3.68157238`
  - `eval_time:1275ms`

## analysis and conclusion

Naively reusing the decoder for extra eval-time passes was strongly harmful. It increased evaluation time and destroyed model quality, which means the extra recurrence did not preserve a useful distribution over next-token logits.

Conclusion: extra evaluation compute is not automatically helpful. In this architecture, naive repeated decoder passes are a bad idea.
