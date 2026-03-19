# Experiments

## Baseline

Baseline command:

```bash
RUN_ID=mlx_local_v2 \
ITERATIONS=100 \
WARMUP_STEPS=0 \
TRAIN_LOG_EVERY=10 \
TRAIN_BATCH_TOKENS=4096 \
GRAD_ACCUM_STEPS=1 \
TRAIN_SEQ_LEN=1024 \
VAL_LOSS_EVERY=0 \
VAL_BATCH_SIZE=65536 \
LOGIT_CHUNK_TOKENS=4096 \
MODEL_DIM=128 \
NUM_LAYERS=4 \
NUM_HEADS=4 \
NUM_KV_HEADS=2 \
MLP_MULT=1 \
python3 train_gpt_mlx.py
```

Baseline result from `logs/mlx_local_v2.txt`:

- `final_int8_zlib_roundtrip_exact val_loss:4.72025585 val_bpb:2.79560139`
- `model_params:461072`
- `serialized_model_int8_zlib:737922 bytes`
- `eval_time:899329ms`

## Local Iteration Protocol

Full local validation is slow. For iterative local experiments, we may use:

```bash
VAL_MAX_TOKENS=1048576
```

This is a local-only validation proxy added to `train_gpt_mlx.py`. When used, results are only comparable to other runs that use the same fixed proxy.

Proxy baseline on the 1M-token validation prefix:

- Run ID: `mlx_local_v2_subset`
- `model_params:461072`
- `final_int8_zlib_roundtrip_exact val_loss:4.70558929 val_bpb:2.81933844`
- `serialized_model_int8_zlib:737967 bytes`

## Scope Note

Experiments `01` through `37` are local Apple Silicon / MLX experiments, generally run from `train_gpt_mlx.py` on a MacBook with the 1M-token local proxy unless otherwise noted. Experiments `38+` are remote CUDA experiments on single-GPU infrastructure using `train_gpt.py`.

## Recording Rule

Going forward, every completed experiment note should include:

- the exact launch command in a fenced `bash` block
- the log path used as the source of truth for recorded metrics
- the run ID and the final exact metric copied from that log

If a sweep contains multiple concrete runs, record one exact command per run ID.

## Tracker

| ID | Experiment | Scope | Status | Run ID | Result |
|---:|------------|-------|--------|--------|--------|
| 01 | Reduce KV heads to 1 | Local knob | Completed | `exp01_kv1` | `val_bpb 2.80573991`, `677455 bytes`, beat proxy baseline |
| 02 | Increase MLP mult to 2 | Local knob | Completed | `exp02_mlp2` | `val_bpb 2.81560697`, `980888 bytes`, slight win vs baseline, weaker than exp01 |
| 03 | Increase layers to 6 | Local knob | Completed | `exp03_layers6` | `val_bpb 2.82994117`, `1046265 bytes`, worse than baseline |
| 04 | Increase model dim to 160 | Local knob | Completed | `exp04_dim160` | `val_bpb 2.77600845`, `1109530 bytes`, best proxy score so far |
| 05 | Depth vs width at similar scale | Local knob | Completed | `exp05_depth6_width96` | `val_bpb 2.82779874`, `581671 bytes`, much smaller but worse quality |
| 06 | Increase iterations to 300 | Local knob | Completed | `exp06_iters300` | `val_bpb 2.58130244`, `742981 bytes`, biggest win so far |
| 07 | Sweep train batch tokens | Local knob | Completed | `exp07_bs2048`, `exp07_bs8192` | `8192` best with `val_bpb 2.68273118` |
| 08 | Sweep learning rates | Local knob | Completed | `exp08_lr_low`, `exp08_lr_high` | low LR best with `val_bpb 2.67582592` |
| 09 | Sweep warmdown schedule | Local knob | Completed | `exp09_wd20`, `exp09_wd50` | `WARMDOWN_ITERS=20` best with `val_bpb 2.63387926` |
| 10 | Sweep QK gain init | Local knob | Completed | `exp10_qk1`, `exp10_qk2` | `QK_GAIN_INIT=2.0` best with `val_bpb 2.62256258` |
| 11 | Sweep logit softcap | Local knob | Completed | `exp11_softcap15`, `exp11_softcap50` | `LOGIT_SOFTCAP=15` best with `val_bpb 2.61667811` |
| 12 | Sweep sequence length and RoPE base | Local knob | Completed | `exp12_seq512_rope10k`, `exp12_seq1024_rope50k`, `exp12_seq2048_rope50k` | `512 / 10000` best with `val_bpb 2.59355021` |
| 13 | Sweep Muon hyperparameters | Local knob | Completed | `exp13_steps3`, `exp13_steps7`, `exp13_mom090`, `exp13_mom095` | `MUON_BACKEND_STEPS=7` best with `val_bpb 2.61415456` |
| 14 | Add layer sharing / recurrence | Code change | Completed | `exp14_share2`, `exp14_share1` | `NUM_UNIQUE_BLOCKS=2` gave `val_bpb 2.62392734` at `426041 bytes` |
| 15 | Alternate cheap and full blocks | Code change | Completed | `exp15_alt_nomlp` | `val_bpb 2.63281561`, `611149 bytes`, weaker than shared blocks |
| 16 | Add low-rank projections | Code change | Completed | `exp16_lrm32`, `exp16_lrm16` | low-rank MLPs saved bytes but hurt quality; `rank 32` least bad at `val_bpb 2.65126125` |
| 17 | Try quantization-aware training | Code change | Completed | `exp17_clip05`, `exp17_clip025` | `POST_STEP_WEIGHT_CLIP=0.5` won with `val_bpb 2.58737833` |
| 18 | Untie or partially tie embeddings | Code change | Completed | `exp18_untied`, `exp18_partial32` | untied head best with `val_bpb 2.58560673`, but larger artifact |
| 19 | Sweep tokenizer families | Local mini-corpus approximation | Completed | `exp19_mini_sp1024`, `exp19_mini_sp512`, `exp19_mini_sp2048` | local mini run favored `sp2048` with `val_bpb 2.66824120` |
| 20 | Add evaluation-time compute | Code change | Completed | `exp20_evalpass1`, `exp20_evalpass2` | extra eval passes were strongly harmful |

## Phase 2

| ID | Experiment | Scope | Status | Run ID | Result |
|---:|------------|-------|--------|--------|--------|
| 21 | Combine `seq512` and `clip0.5` | Local compound | Completed | `exp21_seq512_clip05` | `val_bpb 2.56879698`, new best tied local recipe |
| 22 | Add untied head on top of best local stack | Local compound | Completed | `exp22_seq512_clip05_untied` | `val_bpb 2.53943806`, new best 100-step local result |
| 23 | Scale best compound stack to 300 iterations | Local compound | Completed | `exp23_seq512_clip05_untied_300` | `val_bpb 2.30536380`, strongest local proxy result so far |
| 24 | Size-aware shared stack with local best knobs | Local compound | Completed | `exp24_share2_seq512_clip05` | `val_bpb 2.58399455` at only `422473 bytes` |

## Phase 3

Top `modded-nanogpt` ports to try next, ranked by likely usefulness for parameter-golf rather than raw speedrun impact.

| ID | Experiment | Scope | Status | Run ID | Result |
|---:|------------|-------|--------|--------|--------|
| 25 | Port multi-token prediction | Code change | Completed | `exp25_mtp2` | naive `MTP_TOKENS=2` hurt badly: `val_bpb 2.80020085` |
| 26 | Port bigram hash embedding | Code change | Completed | `exp26_bigram2048` | `val_bpb 2.47139713`, strongest tied 100-step result so far |
| 27 | Port value embeddings | Code change | Completed | `exp27_valueembed` | `val_bpb 2.52248233`, positive but weaker than bigram hash |
| 28 | Port partial key offset | Code change | Completed | `exp28_pko16` | slight regression: `val_bpb 2.57523484` |
| 29 | Port second input embedding | Code change | Completed | `exp29_secondinput` | `val_bpb 2.54946912`, positive but weaker than value embed |
| 30 | Port token smear forward | Code change | Completed | `exp30_smear` | strong regression: `val_bpb 2.61520078` |
| 31 | Port cautious weight decay | Optimizer/code change | Planned |  |  |
| 32 | Port untie/retie schedule | Training schedule/code change | Planned |  |  |
| 33 | Port hyperconnections | Code change | Planned |  |  |
| 34 | Port evaluation-time longer windows | Eval/code change | Planned |  |  |

## Phase 4

| ID | Experiment | Scope | Status | Run ID | Result |
|---:|------------|-------|--------|--------|--------|
| 35 | Compound bigram hash with best 100-step quality stack | Local compound | Completed | `exp35_bigram2048_seq512_clip05_untied` | `val_bpb 2.41771924`, strong compounding win |
| 36 | Scale best bigram-hash compound stack to 300 iterations | Local compound | Completed | `exp36_bigram2048_seq512_clip05_untied_300` | `val_bpb 2.25200604`, strongest local proxy result so far |

## Phase 5

| ID | Experiment | Scope | Status | Run ID | Result |
|---:|------------|-------|--------|--------|--------|
| 37 | Sweep warmup steps on the best local stack | Local systems knob | Completed | `exp37_warmup0`, `exp37_warmup20`, `exp37_warmup40`, `exp37_warmup100` | tiny effect only; `WARMUP_STEPS=40` best with `val_bpb 2.25032972` |

## Phase 6

| ID | Experiment | Scope | Status | Run ID | Result |
|---:|------------|-------|--------|--------|--------|
| 38 | 1xH100 KV1 + bigram + untied remote run | Remote compound | Completed | `exp38_h100_10min_kv1_bigram_untied` | smaller and faster than baseline, but worse final score: `val_bpb 1.56065969` |
| 39 | 1xH100 baseline scale with training-only knobs | Remote training stack | Completed | `exp39_h100_10min_opt_only` | strong regression vs baseline: `val_bpb 1.57489392` |
| 43 | 1xGPU seq warmup + min-LR 0.1 remote run | Remote training schedule | Completed | `exp43_1gpu_seqwarm150_minlr01` | new best recorded single-GPU 10-minute result: `val_bpb 1.49781690` |

## Phase 7

Planned remote replication pass: re-run each local experiment from `01` through `37` as a fresh single-H100 experiment to measure transfer from the MacBook MLX proxy to the real PyTorch/CUDA regime.

| ID | Experiment | Scope | Status | Run ID | Result |
|---:|------------|-------|--------|--------|--------|
| 44 | Re-run experiment 01 on single H100 | Remote replication | Planned |  |  |
| 45 | Re-run experiment 02 on single H100 | Remote replication | Planned |  |  |
| 46 | Re-run experiment 03 on single H100 | Remote replication | Planned |  |  |
| 47 | Re-run experiment 04 on single H100 | Remote replication | Planned |  |  |
| 48 | Re-run experiment 05 on single H100 | Remote replication | Planned |  |  |
| 49 | Re-run experiment 06 on single H100 | Remote replication | Planned |  |  |
| 50 | Re-run experiment 07 on single H100 | Remote replication | Planned |  |  |
| 51 | Re-run experiment 08 on single H100 | Remote replication | Planned |  |  |
| 52 | Re-run experiment 09 on single H100 | Remote replication | Planned |  |  |
| 53 | Re-run experiment 10 on single H100 | Remote replication | Planned |  |  |
| 54 | Re-run experiment 11 on single H100 | Remote replication | Planned |  |  |
| 55 | Re-run experiment 12 on single H100 | Remote replication | Planned |  |  |
| 56 | Re-run experiment 13 on single H100 | Remote replication | Planned |  |  |
| 57 | Re-run experiment 14 on single H100 | Remote replication | Planned |  |  |
| 58 | Re-run experiment 15 on single H100 | Remote replication | Planned |  |  |
| 59 | Re-run experiment 16 on single H100 | Remote replication | Planned |  |  |
| 60 | Re-run experiment 17 on single H100 | Remote replication | Planned |  |  |
| 61 | Re-run experiment 18 on single H100 | Remote replication | Planned |  |  |
| 62 | Re-run experiment 19 on single H100 | Remote replication | Planned |  |  |
| 63 | Re-run experiment 20 on single H100 | Remote replication | Planned |  |  |
| 64 | Re-run experiment 21 on single H100 | Remote replication | Planned |  |  |
| 65 | Re-run experiment 22 on single H100 | Remote replication | Planned |  |  |
| 66 | Re-run experiment 23 on single H100 | Remote replication | Planned |  |  |
| 67 | Re-run experiment 24 on single H100 | Remote replication | Planned |  |  |
| 68 | Re-run experiment 25 on single H100 | Remote replication | Planned |  |  |
| 69 | Re-run experiment 26 on single H100 | Remote replication | Planned |  |  |
| 70 | Re-run experiment 27 on single H100 | Remote replication | Planned |  |  |
| 71 | Re-run experiment 28 on single H100 | Remote replication | Planned |  |  |
| 72 | Re-run experiment 29 on single H100 | Remote replication | Planned |  |  |
| 73 | Re-run experiment 30 on single H100 | Remote replication | Planned |  |  |
| 74 | Re-run experiment 31 on single H100 | Remote replication | Planned |  |  |
| 75 | Re-run experiment 32 on single H100 | Remote replication | Planned |  |  |
| 76 | Re-run experiment 33 on single H100 | Remote replication | Planned |  |  |
| 77 | Re-run experiment 34 on single H100 | Remote replication | Planned |  |  |
| 78 | Re-run experiment 35 on single H100 | Remote replication | Planned |  |  |
| 79 | Re-run experiment 36 on single H100 | Remote replication | Planned |  |  |
| 80 | Re-run experiment 37 on single H100 | Remote replication | Planned |  |  |

## Phase 8

Moonshot architecture phase: prioritize drastic structural changes over iterative optimizer tuning.

| ID | Experiment | Scope | Status | Run ID | Result |
|---:|------------|-------|--------|--------|--------|
| 81 | Residual n-gram prior logits | Moonshot architecture | Planned |  | explicit bigram/trigram logit prior plus transformer residual |
| 82 | Shared/recurrent block stack | Moonshot architecture | Planned |  | many logical layers with few unique weights and per-step modulation |
| 83 | Lexical feature super-stack | Moonshot architecture | Planned |  | combine token, bigram, and value-side lexical features |
| 84 | Structured output head | Moonshot architecture | Planned |  | factorized or low-rank residual head instead of a plain flat projection |
| 85 | Hybrid attention + recurrence mixer | Moonshot architecture | Planned |  | replace part of the stack with cheap recurrent or convolutional mixing |
