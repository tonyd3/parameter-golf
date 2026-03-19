# Experiment 43: 1xGPU Seq Warmup + Min-LR 0.1 Remote Run

## hypothesis

On the baseline-scale single-GPU PyTorch run, starting training at a shorter sequence length and ramping up to `1024` over the first `150` steps should improve optimization efficiency inside a fixed 10-minute wallclock budget. Keeping a nonzero learning-rate floor with `MIN_LR_SCALE=0.1` might also preserve late-run progress once the full sequence length is reached.

## changes

- Keep the baseline architecture exactly:
  - `NUM_LAYERS=9`
  - `MODEL_DIM=512`
  - `NUM_HEADS=8`
  - `NUM_KV_HEADS=4`
  - `MLP_MULT=2`
  - `TIE_EMBEDDINGS=1`
- Keep the baseline token budget and target sequence length:
  - `TRAIN_BATCH_TOKENS=524288`
  - `TRAIN_SEQ_LEN=1024`
- Change the training schedule:
  - `TRAIN_SEQ_LEN_START=512`
  - `SEQ_LEN_WARMUP_STEPS=150`
  - `MIN_LR_SCALE=0.1`
- Keep `WARMUP_STEPS=20`
- Keep `MAX_WALLCLOCK_SECONDS=600`
- Keep `VAL_LOSS_EVERY=0`

## exact command

```bash
RUN_ID=exp43_1gpu_seqwarm150_minlr01 \
DATA_PATH=./data/datasets/fineweb10B_sp1024 \
TOKENIZER_PATH=./data/tokenizers/fineweb_1024_bpe.model \
VOCAB_SIZE=1024 \
MAX_WALLCLOCK_SECONDS=600 \
VAL_LOSS_EVERY=0 \
TRAIN_LOG_EVERY=50 \
WARMUP_STEPS=20 \
ATTN_BACKEND=flash \
MIN_LR_SCALE=0.1 \
TRAIN_BATCH_TOKENS=524288 \
TRAIN_SEQ_LEN=1024 \
TRAIN_SEQ_LEN_START=512 \
SEQ_LEN_WARMUP_STEPS=150 \
NUM_LAYERS=9 \
MODEL_DIM=512 \
NUM_HEADS=8 \
NUM_KV_HEADS=4 \
MLP_MULT=2 \
TIE_EMBEDDINGS=1 \
torchrun --standalone --nproc_per_node=1 train_gpt.py
```

Log source: `logs/exp43_1gpu_seqwarm150_minlr01.txt`

## experiment results

- Baseline comparison point from the same 1xGPU setup
  - `baseline_sp1024`
  - `model_params:17059912`
  - `step:414/20000` at wallclock stop
  - pre-quant stop metric: `val_bpb:1.5248`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.54222932`
  - `Total submission size int8+zlib:9491575 bytes`
- `exp43_1gpu_seqwarm150_minlr01`
  - `model_params:17059912`
  - `step:410/20000` at wallclock stop
  - pre-quant stop metric: `val_loss:2.5140`
  - pre-quant stop metric: `val_bpb:1.4889`
  - `Serialized model int8+zlib:10125457 bytes`
  - `Total submission size int8+zlib:10177280 bytes`
  - `final_int8_zlib_roundtrip_exact val_loss:2.52900110`
  - `final_int8_zlib_roundtrip_exact val_bpb:1.49781690`

## analysis and conclusion

This is a clear improvement over the prior single-GPU baseline. The final exact score improved from `1.54222932` to `1.49781690`, a gain of about `0.0444 val_bpb`, while keeping the same parameter count and nearly the same number of completed steps before the wallclock stop.

The likely reason is that the sequence-length warmup made early optimization cheaper and easier, letting the model learn faster before paying full `1024`-token attention cost. The `MIN_LR_SCALE=0.1` floor also looks compatible with this schedule, since the run continued improving after the switch to full sequence length instead of flattening too aggressively.

The tradeoff is artifact size: the final int8+zlib submission grew from `9491575` bytes to `10177280` bytes. Even so, this run is the strongest recorded 10-minute single-GPU result so far in the tracker, and it establishes seq-length warmup as a promising direction for further remote ablations.
