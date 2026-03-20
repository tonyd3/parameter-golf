# Loop 08 Experiment 04: PKO32 + AltCheap8 + Value + Persistent Memory 8

## command

logs/loop08_exp04_persistent_memory8_best.txt
run_id:loop08_exp04_persistent_memory8_best
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:1200672 vocab_size:1024 layers:8 unique_blocks:8 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
cheap_blocks:enabled every:2 offset:1 cheap_block_mlp_mult:0
bigram_hash:enabled vocab:2048 bos_id:1
value_embed:enabled
partial_key_offset_dims:32
persistent_memory_tokens:8
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:40 scalar_params:49 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9328 train_time:258ms step_avg:258.44ms tok_s:63450
step:2/600 train_loss:6.8694 train_time:428ms step_avg:214.18ms tok_s:96636
step:3/600 train_loss:5.8536 train_time:526ms step_avg:175.25ms tok_s:168730
step:4/600 train_loss:5.4933 train_time:628ms step_avg:157.07ms tok_s:160376
step:5/600 train_loss:5.2884 train_time:727ms step_avg:145.43ms tok_s:166136
step:6/600 train_loss:5.1594 train_time:832ms step_avg:138.73ms tok_s:156063
step:7/600 train_loss:5.0618 train_time:919ms step_avg:131.35ms tok_s:188680
step:8/600 train_loss:4.9349 train_time:1008ms step_avg:125.98ms tok_s:185855
step:9/600 train_loss:4.8720 train_time:1096ms step_avg:121.75ms tok_s:186783
step:10/600 train_loss:4.7923 train_time:1186ms step_avg:118.57ms tok_s:182532
step:30/600 train_loss:4.3516 train_time:3070ms step_avg:102.32ms tok_s:172751
step:60/600 train_loss:3.8910 train_time:5553ms step_avg:92.55ms tok_s:203444
step:90/600 train_loss:3.9131 train_time:8151ms step_avg:90.57ms tok_s:196351
step:120/600 train_loss:3.6107 train_time:10605ms step_avg:88.37ms tok_s:195179
step:150/600 train_loss:3.5401 train_time:13054ms step_avg:87.03ms tok_s:206463
step:180/600 train_loss:3.7725 train_time:15546ms step_avg:86.37ms tok_s:211604
step:210/600 train_loss:3.5393 train_time:17998ms step_avg:85.70ms tok_s:187851
step:240/600 train_loss:3.6342 train_time:20717ms step_avg:86.32ms tok_s:210372
step:270/600 train_loss:3.2794 train_time:23756ms step_avg:87.99ms tok_s:77645
step:300/600 train_loss:3.1180 train_time:26813ms step_avg:89.38ms tok_s:205472
step:330/600 train_loss:3.3391 train_time:29427ms step_avg:89.17ms tok_s:181416
step:360/600 train_loss:3.2268 train_time:31841ms step_avg:88.45ms tok_s:210034
step:390/600 train_loss:3.2585 train_time:34209ms step_avg:87.72ms tok_s:208418
step:420/600 train_loss:3.0952 train_time:36620ms step_avg:87.19ms tok_s:207412
step:450/600 train_loss:3.4029 train_time:39022ms step_avg:86.72ms tok_s:205759
step:480/600 train_loss:3.2596 train_time:41410ms step_avg:86.27ms tok_s:199769
step:510/600 train_loss:3.1960 train_time:43783ms step_avg:85.85ms tok_s:208842
step:540/600 train_loss:3.1783 train_time:46184ms step_avg:85.53ms tok_s:187944
step:570/600 train_loss:3.3039 train_time:48566ms step_avg:85.20ms tok_s:210519
step:600/600 train_loss:3.1770 train_time:50926ms step_avg:84.88ms tok_s:210004
step:600/600 val_loss:3.1843 val_bpb:1.9079 train_time:53486ms step_avg:89.14ms
saved_model:logs/loop08_exp04_persistent_memory8_best_mlx_model.npz bytes:3775298
serialized_model_int8_zlib:1623165 bytes (payload:1765504 raw_pickle:1771754 payload_ratio:2.13x)
final_int8_zlib_roundtrip val_loss:3.1849 val_bpb:1.9082 eval_time:1585ms
final_int8_zlib_roundtrip_exact val_loss:3.18490076 val_bpb:1.90822288

## hypothesis

A small persistent memory bank may replace some FFN-style function with cheaper learned memory readout.

## results / data

- 
- 
- 
- 
- 
- 
- 
- 
- 

## analysis

Strongly supported. Eight persistent memory slots improved quality meaningfully without the severe runtime penalty of talking-heads, which makes this a high-value direction.
