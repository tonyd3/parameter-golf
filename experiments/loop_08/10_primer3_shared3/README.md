# Loop 08 Experiment 10: PKO32 + Shared3 Layers12 + Primer Depthwise Conv k=3

## command

logs/loop08_exp10_primer3_shared3.txt
run_id:loop08_exp10_primer3_shared3
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:774668 vocab_size:1024 layers:12 unique_blocks:3 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
bigram_hash:enabled vocab:2048 bos_id:1
partial_key_offset_dims:32
primer_depthwise_kernel:3
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:27 scalar_params:13 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9337 train_time:80ms step_avg:79.58ms tok_s:205910
step:2/600 train_loss:6.8859 train_time:218ms step_avg:109.10ms tok_s:118572
step:3/600 train_loss:5.8682 train_time:315ms step_avg:104.88ms tok_s:170321
step:4/600 train_loss:5.5309 train_time:407ms step_avg:101.68ms tok_s:178840
step:5/600 train_loss:5.2534 train_time:493ms step_avg:98.62ms tok_s:190007
step:6/600 train_loss:5.1466 train_time:572ms step_avg:95.38ms tok_s:207528
step:7/600 train_loss:5.0354 train_time:657ms step_avg:93.81ms tok_s:194655
step:8/600 train_loss:4.9052 train_time:739ms step_avg:92.37ms tok_s:199563
step:9/600 train_loss:4.8278 train_time:821ms step_avg:91.26ms tok_s:199296
step:10/600 train_loss:4.7411 train_time:905ms step_avg:90.47ms tok_s:196934
step:30/600 train_loss:4.3439 train_time:3754ms step_avg:125.13ms tok_s:110397
step:60/600 train_loss:3.9354 train_time:8406ms step_avg:140.10ms tok_s:101429
step:90/600 train_loss:3.9745 train_time:13430ms step_avg:149.22ms tok_s:93820
step:120/600 train_loss:3.7555 train_time:18279ms step_avg:152.32ms tok_s:103295
step:150/600 train_loss:3.6742 train_time:23008ms step_avg:153.39ms tok_s:100704
step:180/600 train_loss:3.8505 train_time:28083ms step_avg:156.01ms tok_s:105881
step:210/600 train_loss:3.6384 train_time:32882ms step_avg:156.58ms tok_s:98801
step:240/600 train_loss:3.7152 train_time:37539ms step_avg:156.41ms tok_s:109254
step:270/600 train_loss:3.3685 train_time:42138ms step_avg:156.07ms tok_s:109246
step:300/600 train_loss:3.2222 train_time:46857ms step_avg:156.19ms tok_s:104540
step:330/600 train_loss:3.4169 train_time:51586ms step_avg:156.32ms tok_s:104089
step:360/600 train_loss:3.3092 train_time:57061ms step_avg:158.50ms tok_s:111067
step:390/600 train_loss:3.3967 train_time:62269ms step_avg:159.66ms tok_s:100969
step:420/600 train_loss:3.2159 train_time:67060ms step_avg:159.67ms tok_s:102348
step:450/600 train_loss:3.4863 train_time:72090ms step_avg:160.20ms tok_s:94991
step:480/600 train_loss:3.3429 train_time:77138ms step_avg:160.70ms tok_s:99434
step:510/600 train_loss:3.2625 train_time:82053ms step_avg:160.89ms tok_s:105299
step:540/600 train_loss:3.2610 train_time:87065ms step_avg:161.23ms tok_s:91898
step:570/600 train_loss:3.3793 train_time:91054ms step_avg:159.74ms tok_s:164749
step:600/600 train_loss:3.2475 train_time:96840ms step_avg:161.40ms tok_s:63139
step:600/600 val_loss:3.2627 val_bpb:1.9549 train_time:99707ms step_avg:166.18ms
saved_model:logs/loop08_exp10_primer3_shared3_mlx_model.npz bytes:2322150
serialized_model_int8_zlib:958388 bytes (payload:1037872 raw_pickle:1041038 payload_ratio:2.23x)
final_int8_zlib_roundtrip val_loss:3.2634 val_bpb:1.9553 eval_time:2428ms
final_int8_zlib_roundtrip_exact val_loss:3.26339984 val_bpb:1.95525535

## hypothesis

Primer-style local bias may compound with recurrent/shared depth better than lexical side features alone.

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

Not supported. Primer helped the full-quality stack, but it did not rescue the shared-depth regime enough to compete with the persistent-memory hybrid on the same size frontier.
