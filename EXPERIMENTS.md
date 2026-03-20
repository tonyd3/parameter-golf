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

For standard local comparison loops, also fix:

```bash
ITERATIONS=600
```

This is the local stand-in for the contest’s fixed time budget. Local runs above `600` steps are still useful, but they should be treated as exploratory step-scaling evidence rather than the default apples-to-apples benchmark.

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

## Loop 01

Structured self-improvement loop scaffolded under [experiments/loop_01](/Users/tony/dev/parameter-golf/experiments/loop_01/README.md). This loop uses the current best single-H100 remote run, `exp43_1gpu_seqwarm150_minlr01`, as the comparison anchor.

| Rank | Experiment Folder | Scope | Status | Planned Run ID | Focus |
|----:|-------------------|-------|--------|----------------|-------|
| 1 | `loop_01/01_seqwarm_only` | Isolation | Scaffolded | `loop01_exp01_seqwarm_only` | remove `MIN_LR_SCALE` and keep seq warmup |
| 2 | `loop_01/02_minlr_only` | Isolation | Scaffolded | `loop01_exp02_minlr_only` | remove seq warmup and keep `MIN_LR_SCALE=0.1` |
| 3 | `loop_01/03_seqwarm_200` | Exploitation | Scaffolded | `loop01_exp03_seqwarm200` | extend short-context phase |
| 4 | `loop_01/04_seqwarm_050` | Isolation | Scaffolded | `loop01_exp04_seqwarm050` | shorten short-context phase |
| 5 | `loop_01/05_seqstart_256` | Exploitation | Scaffolded | `loop01_exp05_seqstart256` | start at even shorter sequence length |
| 6 | `loop_01/06_minlr_005` | Exploitation | Scaffolded | `loop01_exp06_minlr005` | lower the LR floor |
| 7 | `loop_01/07_minlr_020` | Isolation | Scaffolded | `loop01_exp07_minlr020` | raise the LR floor |
| 8 | `loop_01/08_batch_393216` | Systems | Scaffolded | `loop01_exp08_batch393216` | smaller token batch |
| 9 | `loop_01/09_batch_655360` | Systems | Scaffolded | `loop01_exp09_batch655360` | larger token batch |
| 10 | `loop_01/10_bigram2048_best_sched` | Wildcard | Scaffolded | `loop01_exp10_bigram2048` | re-test bigram hash on the best remote schedule |

## Loop 02

Active local MLX self-improvement loop scaffolded under [experiments/loop_02](/Users/tony/dev/parameter-golf/experiments/loop_02/README.md). This loop uses the best recorded local proxy result, `exp37_warmup40`, as its current comparison anchor and upgrades all new local runs to at least `600` iterations.

| Rank | Experiment Folder | Scope | Status | Planned Run ID | Focus |
|----:|-------------------|-------|--------|----------------|-------|
| 1 | `loop_02/01_anchor_600` | Exploitation | Completed | `loop02_exp01_anchor600` | `val_bpb 2.18845266`, `1043961 bytes`, new best local proxy result |
| 2 | `loop_02/02_warmdown_120` | Schedule | Completed | `loop02_exp02_warmdown120` | `val_bpb 2.15940515`, `1046216 bytes`, new best local proxy result |
| 3 | `loop_02/03_bigram_4096` | Exploitation | Completed | `loop02_exp03_bigram4096` | `val_bpb 2.16443825`, `1271908 bytes`, slight regression vs loop02 exp02 |
| 4 | `loop_02/04_retie_embeddings` | Isolation | Completed | `loop02_exp04_retie` | `val_bpb 2.23452219`, `944823 bytes`, tied head regressed but saved size |
| 5 | `loop_02/05_no_clip` | Isolation | Completed | `loop02_exp05_noclip` | `val_bpb 2.14198973`, `1106239 bytes`, new best local quality result with larger compressed size |
| 6 | `loop_02/06_no_bigram` | Isolation | Completed | `loop02_exp06_nobigram` | `val_bpb 2.22662314`, `817851 bytes`, confirms bigram hash is materially helping |
| 7 | `loop_02/07_value_embed_best` | Feature compound | Completed | `loop02_exp07_valueembed` | `val_bpb 2.17812277`, `1147080 bytes`, positive overall but weaker than the anchor |
| 8 | `loop_02/08_second_input_best` | Wildcard feature | Completed | `loop02_exp08_secondinput` | `val_bpb 2.18034948`, `1146112 bytes`, positive overall but weaker than the anchor |
| 9 | `loop_02/09_batch_4096` | Systems | Completed | `loop02_exp09_batch4096` | `val_bpb 2.29994173`, `1043356 bytes`, much worse despite faster steps |
| 10 | `loop_02/10_batch_16384` | Systems | Completed | `loop02_exp10_batch16384` | `val_bpb 2.12161593`, `1044469 bytes`, new best local proxy result |

## Loop 03

Follow-up local loop seeded by the two strongest independent wins from `loop_02`: larger batch and no clipping.

| Rank | Experiment Folder | Scope | Status | Run ID | Result |
|----:|-------------------|-------|--------|--------|--------|
| 1 | `loop_03/01_batch16384_noclip` | Compound pilot | Completed | `loop03_pilot_batch16384_noclip` | `val_bpb 2.07760213`, `1104375 bytes`, new best local quality result |
| 2 | `loop_03/02_batch16384_noclip_warmdown120` | Schedule compound | Completed | `loop03_exp02_batch16384_noclip_warmdown120` | `val_bpb 2.06218386`, `1105923 bytes`, new best local quality result |
| 3 | `loop_03/03_iters900_best_stack` | Step scaling | Completed | `loop03_exp03_iters900_best` | exploratory: `val_bpb 2.01173704`, `1104197 bytes`, not part of fixed-600 comparison set |
| 4 | `loop_03/04_iters1200_best_stack` | Step scaling | Completed | `loop03_exp04_iters1200_best` | exploratory: `val_bpb 1.99389637`, `1105964 bytes`, not part of fixed-600 comparison set |

## Loop 04

Moonshot local loop built around higher-variance structural hypotheses while keeping `ITERATIONS=600` fixed.

| Rank | Experiment Folder | Scope | Status | Run ID | Result |
|----:|-------------------|-------|--------|--------|--------|
| 1 | `loop_04/01_lexical_superstack` | Moonshot lexical | Completed | `loop04_exp01_lexical_superstack` | `val_bpb 2.05506490`, `1337766 bytes`, modest quality win with a real size cost |
| 2 | `loop_04/02_shared2_layers8` | Moonshot recurrence | Completed | `loop04_exp02_shared2_layers8` | `val_bpb 2.08338631`, `798448 bytes`, weaker quality but very strong size reduction |
| 3 | `loop_04/03_shared3_layers12` | Moonshot recurrence | Completed | `loop04_exp03_shared3_layers12` | `val_bpb 2.06956308`, `953739 bytes`, still weaker than the anchor but size-efficient |
| 4 | `loop_04/04_shared2_layers8_lexical` | Compound moonshot | Completed | `loop04_exp04_shared2_layers8_lexical` | `val_bpb 2.08069849`, `1032495 bytes`, better than pure shared2 but worse than the anchor |
| 5 | `loop_04/05_partial_key_offset16` | Moonshot attention | Completed | `loop04_exp05_partialkey16` | `val_bpb 1.99532927`, `1105520 bytes`, new best fixed-600 local result |
| 6 | `loop_04/06_mtp2_best` | Moonshot objective | Completed | `loop04_exp06_mtp2` | `val_bpb 2.35199772`, `1098861 bytes`, strongly negative again |
| 7 | `loop_04/07_altcheap_layers8` | Moonshot hybrid depth | Completed | `loop04_exp07_altcheap8` | `val_bpb 2.04854176`, `1477865 bytes`, real quality win over the anchor but still behind partial-key |
| 8 | `loop_04/08_lowrank32_dim160` | Moonshot width/structure | Completed | `loop04_exp08_lowrank32_dim160` | `val_bpb 2.06846816`, `1340030 bytes`, slight regression with larger artifact |
| 9 | `loop_04/09_token_smear_best` | Moonshot lexical | Completed | `loop04_exp09_tokensmear` | `val_bpb 2.09031857`, `1101505 bytes`, still negative on the stronger stack |
| 10 | `loop_04/10_shared1_layers12` | Extreme moonshot | Completed | `loop04_exp10_shared1_layers12` | `val_bpb 2.10566413`, `646059 bytes`, poor quality but exceptional size efficiency |

## Loop 05

PKO-centered moonshot loop that compounds the strongest `loop_04` win with the next most plausible structural and lexical variants while keeping `ITERATIONS=600` fixed.

| Rank | Experiment Folder | Scope | Status | Planned Run ID | Focus |
|----:|-------------------|-------|--------|----------------|-------|
| 1 | `loop_05/01_pko16_altcheap8` | Compound moonshot | Completed | `loop05_exp01_pko16_altcheap8` | `val_bpb 1.97023378`, `1476051 bytes`, new best fixed-600 local result |
| 2 | `loop_05/02_pko16_lexical_superstack` | Compound moonshot | Completed | `loop05_exp02_pko16_lexical` | `val_bpb 1.97056948`, `1336971 bytes`, nearly tied with the new best and smaller |
| 3 | `loop_05/03_pko08` | Parameter sweep | Completed | `loop05_exp03_pko08` | `val_bpb 2.06938981`, `1104113 bytes`, strong regression so PKO8 is not competitive |
| 4 | `loop_05/04_pko32` | Parameter sweep | Completed | `loop05_exp04_pko32` | `val_bpb 1.96638761`, `1104729 bytes`, new best fixed-600 local result |
| 5 | `loop_05/05_pko16_shared3_layers12` | Quality/bytes hybrid | Completed | `loop05_exp05_pko16_shared3` | `val_bpb 2.00189255`, `954048 bytes`, strong quality/bytes hybrid |
| 6 | `loop_05/06_pko16_shared2_layers8` | Quality/bytes hybrid | Completed | `loop05_exp06_pko16_shared2` | `val_bpb 2.02254162`, `798494 bytes`, smaller but weaker than shared3 |
| 7 | `loop_05/07_pko16_lowrank32_dim160` | Width/structure hybrid | Completed | `loop05_exp07_pko16_lowrank160` | `val_bpb 2.03997304`, `1340151 bytes`, still not competitive |
| 8 | `loop_05/08_pko16_value_embed` | Lexical isolation | Completed | `loop05_exp08_pko16_valueembed` | `val_bpb 1.97729503`, `1223300 bytes`, strong positive but behind the PKO leaders |
| 9 | `loop_05/09_pko16_second_input` | Lexical isolation | Completed | `loop05_exp09_pko16_secondinput` | `val_bpb 1.98834388`, `1219910 bytes`, positive but weaker than value embed |
| 10 | `loop_05/10_pko16_shared1_layers12` | Extreme size frontier | Completed | `loop05_exp10_pko16_shared1` | `val_bpb 2.06400459`, `645535 bytes`, still only interesting for extreme size efficiency |

## Loop 06

PKO32-centered loop that carries the new best attention bias forward and tests whether the strongest `loop_05` compounds keep improving.

| Rank | Experiment Folder | Scope | Status | Planned Run ID | Focus |
|----:|-------------------|-------|--------|----------------|-------|
| 1 | `loop_06/01_pko32_altcheap8` | Compound moonshot | Completed | `loop06_exp01_pko32_altcheap8` | `val_bpb 1.94548370`, `1479360 bytes`, strong frontier improvement over PKO32 base |
| 2 | `loop_06/02_pko32_lexical_superstack` | Compound moonshot | Completed | `loop06_exp02_pko32_lexical` | `val_bpb 1.94168810`, `1336307 bytes`, new best fixed-600 local result |
| 3 | `loop_06/03_pko32_value_embed` | Lexical isolation | Completed | `loop06_exp03_pko32_valueembed` | `val_bpb 1.94968586`, `1223545 bytes`, strong but still behind the full lexical stack |
| 4 | `loop_06/04_pko32_second_input` | Lexical isolation | Completed | `loop06_exp04_pko32_secondinput` | `val_bpb 1.95827272`, `1220709 bytes`, positive but weaker than value-only |
| 5 | `loop_06/05_pko48` | Parameter sweep | Completed | `loop06_exp05_pko48` | `val_bpb 1.96573380`, `1106232 bytes`, slightly worse than PKO32 so the sweep likely peaked |
| 6 | `loop_06/06_pko64` | Parameter sweep | Completed | `loop06_exp06_pko64` | `val_bpb 1.96631690`, `1106993 bytes`, confirms PKO32 is the peak so far |
| 7 | `loop_06/07_pko32_shared3_layers12` | Quality/bytes hybrid | Completed | `loop06_exp07_pko32_shared3` | `val_bpb 1.97217794`, `952069 bytes`, excellent balanced quality/bytes result |
| 8 | `loop_06/08_pko32_shared2_layers8` | Quality/bytes hybrid | Completed | `loop06_exp08_pko32_shared2` | `val_bpb 1.99077414`, `799070 bytes`, improved but still weaker than shared3 |
| 9 | `loop_06/09_pko32_altcheap8_value` | Compound moonshot | Completed | `loop06_exp09_pko32_altcheap8_value` | `val_bpb 1.92565973`, `1593264 bytes`, new best fixed-600 local result |
| 10 | `loop_06/10_pko32_shared1_layers12` | Extreme size frontier | Completed | `loop06_exp10_pko32_shared1` | `val_bpb 2.01895114`, `645225 bytes`, still only interesting for extreme size efficiency |

## Loop 07

Single-H100 candidate pack that ports the strongest local `PKO32`/lexical/depth ideas onto the CUDA trainer and keeps the best known remote schedule fixed.

| Rank | Experiment Folder | Scope | Status | Planned Run ID | Focus |
|----:|-------------------|-------|--------|----------------|-------|
| 1 | `loop_07/01_sched_anchor` | Remote anchor | Scaffolded | `loop07_exp01_sched_anchor` | best existing single-H100 schedule anchor |
| 2 | `loop_07/02_pko32_bigram` | Lower-risk port | Scaffolded | `loop07_exp02_pko32_bigram` | add PKO32 and bigram only |
| 3 | `loop_07/03_pko64_bigram` | Lower-risk port | Scaffolded | `loop07_exp03_pko64_bigram` | full-head PKO analog with bigram |
| 4 | `loop_07/04_pko64_value` | Lexical compound | Scaffolded | `loop07_exp04_pko64_value` | strongest simple lexical branch under PKO64 |
| 5 | `loop_07/05_pko64_lexical_superstack` | Lexical compound | Scaffolded | `loop07_exp05_pko64_lexical` | full lexical compound under PKO64 |
| 6 | `loop_07/06_pko64_altcheap` | Depth compound | Scaffolded | `loop07_exp06_pko64_altcheap` | alternating cheap depth under PKO64 |
| 7 | `loop_07/07_pko64_altcheap_value` | Main contender | Scaffolded | `loop07_exp07_pko64_altcheap_value` | closest H100 analog of the best local result |
| 8 | `loop_07/08_pko64_shared3` | Quality/bytes hybrid | Scaffolded | `loop07_exp08_pko64_shared3` | strongest shared-depth hybrid on H100 |
| 9 | `loop_07/09_pko32_altcheap_value` | Lower-risk contender | Scaffolded | `loop07_exp09_pko32_altcheap_value` | half-head PKO version of the best local analog |
| 10 | `loop_07/10_pko64_lexical_untied` | Aggressive contender | Scaffolded | `loop07_exp10_pko64_lexical_untied` | highest-upside untied lexical PKO candidate |

## Loop 08

Research-backed moonshot local loop built around the `loop_06` frontier and grounded in Primer, talking-heads, persistent memory, and related architectural papers while keeping `ITERATIONS=600` fixed.

| Rank | Experiment Folder | Scope | Status | Run ID | Result |
|----:|-------------------|-------|--------|--------|--------|
| 1 | `loop_08/01_primer3_best` | Attention moonshot | Completed | `loop08_exp01_primer3_best` | `val_bpb 1.91259716`, `1604166 bytes`, strong Primer win over the prior frontier |
| 2 | `loop_08/02_primer5_best` | Attention moonshot | Completed | `loop08_exp02_primer5_best` | `val_bpb 1.91378580`, `1612248 bytes`, slightly behind the best overall but better than Primer k=3 in its first clean run |
| 3 | `loop_08/03_talking_heads_best` | Attention moonshot | Completed | `loop08_exp03_talking_heads_best` | `val_bpb 1.91089170`, `1594025 bytes`, strong quality result but with a severe runtime penalty |
| 4 | `loop_08/04_persistent_memory8_best` | Memory moonshot | Completed | `loop08_exp04_persistent_memory8_best` | `val_bpb 1.91069757`, `1627212 bytes`, strong win with a much better speed profile than talking-heads |
| 5 | `loop_08/05_persistent_memory16_best` | Memory moonshot | Completed | `loop08_exp05_persistent_memory16_best` | `val_bpb 1.90753035`, `1658295 bytes`, new best fixed-600 local result |
| 6 | `loop_08/06_hyperconnections_best` | Residual moonshot | Completed | `loop08_exp06_hyperconnections_best` | `val_bpb 1.92536860`, `1596691 bytes`, near-anchor quality but not a real improvement |
| 7 | `loop_08/07_swiglu_best` | MLP moonshot | Completed | `loop08_exp07_swiglu_best` | `val_bpb 1.92762046`, `1602107 bytes`, budget-matched SwiGLU regressed |
| 8 | `loop_08/08_delight_schedule8` | Depth-allocation moonshot | Completed | `loop08_exp08_delight_schedule8` | `val_bpb 1.92686165`, `1966189 bytes`, more complex uneven depth lost to the simpler altcheap rule |
| 9 | `loop_08/09_persistent8_shared3` | Quality/bytes hybrid | Completed | `loop08_exp09_persistent8_shared3` | `val_bpb 1.94899990`, `964489 bytes`, best size-aware moonshot in this loop |
| 10 | `loop_08/10_primer3_shared3` | Quality/bytes hybrid | Completed | `loop08_exp10_primer3_shared3` | `val_bpb 1.95657297`, `958689 bytes`, weaker than the shared-depth memory hybrid |

## Loop 12

Next single-H100 remote loop built from the strongest portable local ideas and the best proven remote schedule, while avoiding the unsupported local-only features and the old `altcheap`-driven DDP failure mode.

| Rank | Experiment Folder | Scope | Status | Run ID | Focus |
|----:|-------------------|-------|--------|--------|-------|
| 1 | `loop_12/01_sched_anchor_repro` | Remote anchor | Scaffolded | `loop12_exp01_sched_anchor_repro` | reproduce the best known single-H100 schedule |
| 2 | `loop_12/02_pko32_bigram` | Lower-risk port | Scaffolded | `loop12_exp02_pko32_bigram` | safest PKO + lexical transfer |
| 3 | `loop_12/03_pko32_bigram_value` | Main contender | Scaffolded | `loop12_exp03_pko32_bigram_value` | strongest simple transferable compound |
| 4 | `loop_12/04_pko32_bigram_value_secondinput` | Lexical compound | Scaffolded | `loop12_exp04_pko32_bigram_value_secondinput` | full lexical stack on PKO32 |
| 5 | `loop_12/05_pko32_bigram_value_batch655360` | Systems compound | Scaffolded | `loop12_exp05_pko32_bigram_value_batch655360` | larger-batch test on the main contender |
| 6 | `loop_12/06_pko32_bigram_value_batch786432` | Systems compound | Scaffolded | `loop12_exp06_pko32_bigram_value_batch786432` | more aggressive larger-batch test |
| 7 | `loop_12/07_pko32_bigram_value_warmdown180` | Schedule compound | Scaffolded | `loop12_exp07_pko32_bigram_value_warmdown180` | longer cooldown on the main contender |
| 8 | `loop_12/08_pko32_bigram_value_untied` | Output-head test | Scaffolded | `loop12_exp08_pko32_bigram_value_untied` | revisit untied head in a cleaner context |
| 9 | `loop_12/09_pko64_bigram_value_noalt` | Width test | Scaffolded | `loop12_exp09_pko64_bigram_value_noalt` | higher-risk PKO width test without altcheap |
| 10 | `loop_12/10_shared3_pko32_bigram` | Quality/bytes hybrid | Scaffolded | `loop12_exp10_shared3_pko32_bigram` | strongest shared-depth remote hybrid |

## Loop 09

Persistent-memory follow-up loop that treats `loop08_exp05_persistent_memory16_best` as the new anchor and tests memory scaling plus compounds with Primer, talking-heads, and shared depth.

| Rank | Experiment Folder | Scope | Status | Run ID | Result |
|----:|-------------------|-------|--------|--------|--------|
| 1 | `loop_09/01_pmem16_anchor` | Repro anchor | Completed | `loop09_exp01_pmem16_anchor` | `val_bpb 1.90786090`, `1657104 bytes`, clean reproduction of the loop-08 winner |
| 2 | `loop_09/02_pmem24_best` | Memory sweep | Completed | `loop09_exp02_pmem24_best` | `val_bpb 1.90110292`, `1687560 bytes`, memory sweep improved at 24 |
| 3 | `loop_09/03_pmem32_best` | Memory sweep | Completed | `loop09_exp03_pmem32_best` | `val_bpb 1.90630486`, `1717935 bytes`, sweep regressed again at 32 |
| 4 | `loop_09/04_pmem16_primer5` | Attention compound | Completed | `loop09_exp04_pmem16_primer5` | `val_bpb 1.89522831`, `1676633 bytes`, strong compound win |
| 5 | `loop_09/05_pmem24_primer5` | Attention compound | Completed | `loop09_exp05_pmem24_primer5` | `val_bpb 1.89137299`, `1707973 bytes`, new best fixed-600 local result |
| 6 | `loop_09/06_pmem16_no_value` | Lexical ablation | Completed | `loop09_exp06_pmem16_no_value` | `val_bpb 1.92796215`, `1539184 bytes`, confirms value embedding still matters |
| 7 | `loop_09/07_pmem16_shared3` | Quality/bytes hybrid | Completed | `loop09_exp07_pmem16_shared3` | `val_bpb 1.94903190`, `975626 bytes`, still bytes-efficient but behind on quality |
| 8 | `loop_09/08_pmem16_primer5_shared3` | Quality/bytes hybrid | Completed | `loop09_exp08_pmem16_primer5_shared3` | `val_bpb 1.94156468`, `983048 bytes`, best shared-depth result in the loop |
| 9 | `loop_09/09_pmem16_talking_heads` | Attention compound | Completed | `loop09_exp09_pmem16_talking_heads` | `val_bpb 1.89217451`, `1656443 bytes`, very strong quality but severe runtime cost |
| 10 | `loop_09/10_pmem16_no_bigram` | Lexical ablation | Completed | `loop09_exp10_pmem16_no_bigram` | `val_bpb 1.92763803`, `1406309 bytes`, confirms bigram hash still matters |

## Loop 10

Refinement loop around `pmem24 + primer5`, focused on finding the local peak more precisely and testing one size-aware hybrid, one lexical add-on, one altcheap isolation, and one larger-batch systems candidate.

| Rank | Experiment Folder | Scope | Status | Run ID | Focus |
|----:|-------------------|-------|--------|--------|-------|
| 1 | `loop_10/01_pmem24_primer5_anchor` | Repro anchor | Scaffolded | `loop10_exp01_pmem24_primer5_anchor` | verify the new loop_09 winner before refining |
| 2 | `loop_10/02_pmem20_primer5` | Memory refinement | Scaffolded | `loop10_exp02_pmem20_primer5` | test whether the memory peak sits below 24 |
| 3 | `loop_10/03_pmem28_primer5` | Memory refinement | Scaffolded | `loop10_exp03_pmem28_primer5` | test whether the memory peak sits above 24 |
| 4 | `loop_10/04_pmem24_primer3` | Primer refinement | Scaffolded | `loop10_exp04_pmem24_primer3` | shorter local kernel on the best stack |
| 5 | `loop_10/05_pmem24_primer7` | Primer refinement | Scaffolded | `loop10_exp05_pmem24_primer7` | longer local kernel on the best stack |
| 6 | `loop_10/06_pmem24_primer5_talking_heads` | Expensive quality shot | Scaffolded | `loop10_exp06_pmem24_primer5_talking_heads` | see if talking-heads compounds with the new frontier |
| 7 | `loop_10/07_pmem24_primer5_shared3` | Quality/bytes hybrid | Scaffolded | `loop10_exp07_pmem24_primer5_shared3` | push the shared-depth hybrid with the new best stack |
| 8 | `loop_10/08_pmem24_primer5_second_input` | Lexical add-on | Scaffolded | `loop10_exp08_pmem24_primer5_second_input` | retry second-input on the stronger memory+Primer regime |
| 9 | `loop_10/09_pmem24_primer5_no_altcheap` | Isolation | Scaffolded | `loop10_exp09_pmem24_primer5_no_altcheap` | test whether altcheap is still helping |
| 10 | `loop_10/10_pmem24_primer5_batch24576` | Systems | Scaffolded | `loop10_exp10_pmem24_primer5_batch24576` | test a larger fixed-600 local batch |
