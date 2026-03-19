# Phase 7: Single-A40 Replication Gate

This note separates the local experiments that can be replayed directly on the PyTorch/CUDA path from the ones that cannot.

Current environment note:

- The workspace currently has an `NVIDIA A40`, so this phase should be treated as single-A40 replication unless moved to a different box.
- The launch script added for this phase is [`scripts/run_h100_phase7.sh`](/workspace/parameter-golf/scripts/run_h100_phase7.sh).

## directly launchable now

These experiments map cleanly onto [`train_gpt.py`](/workspace/parameter-golf/train_gpt.py) and can be launched on the current single-A40 box with the Phase 7 runner:

- `44` from local `01`: `NUM_KV_HEADS=1`
- `51` from local `08`: low/high learning-rate sweep
- `53` from local `10`: `QK_GAIN_INIT` sweep
- `54` from local `11`: `LOGIT_SOFTCAP` sweep
- `55` from local `12`: sequence-length / RoPE sweep
- `56` from local `13`: Muon hyperparameter sweep
- `60` from local `17`: `POST_STEP_WEIGHT_CLIP` sweep
- `61` from local `18`: untied head only
- `64` from local `21`: `TRAIN_SEQ_LEN=512` plus `POST_STEP_WEIGHT_CLIP=0.5`
- `65` from local `22`: `seq512 + clip0.5 + untied`
- `69` from local `26`: `BIGRAM_HASH_VOCAB=2048` on top of the tied `seq512 + clip0.5` stack
- `78` from local `35`: `bigram + seq512 + clip0.5 + untied`

## blocked or non-comparable

These Phase 7 items should not be launched as blind “replays”:

- `45`: local `02` is a no-op because the remote baseline already uses `MLP_MULT=2`
- `46`, `47`, `48`: the local baseline shape does not map directly onto the 9-layer, 512-dim A40 baseline
- `49`, `66`, `79`: longer-run local experiments are not comparable to the fixed 10-minute remote regime
- `50`: the local batch-token sweep values do not map cleanly to the A40 baseline token budget
- `52`: the local warmdown sweep depended on disabling the wallclock cap
- `57`, `58`, `59`, `63`, `68`, `70`, `71`, `72`, `73`: these depend on features not implemented in [`train_gpt.py`](/workspace/parameter-golf/train_gpt.py)
- `62`: tokenizer-family reruns need `sp512` and `sp2048` assets that are not present here
- `74`, `75`, `76`, `77`: the source local experiments were never completed
- `80`: the local warmup experiment was MLX-specific and does not transfer cleanly

## next step

On the current A40 machine, start with:

```bash
scripts/run_h100_phase7.sh list
scripts/run_h100_phase7.sh 44
scripts/run_h100_phase7.sh 51
scripts/run_h100_phase7.sh 53
```

The runner prints the exact command before each launch so the command can be copied into the corresponding experiment note after completion.
