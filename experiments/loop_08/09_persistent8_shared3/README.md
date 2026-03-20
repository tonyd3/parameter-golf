# Loop 08 Experiment 09: PKO32 + Shared3 Layers12 + Persistent Memory 8

## command

logs/loop08_exp09_persistent8_shared3.txt
run_id:loop08_exp09_persistent8_shared3
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:778508 vocab_size:1024 layers:12 unique_blocks:3 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
bigram_hash:enabled vocab:2048 bos_id:1
partial_key_offset_dims:32
persistent_memory_tokens:8
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:18 scalar_params:19 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9333 train_time:43ms step_avg:42.55ms tok_s:385148
step:2/600 train_loss:6.8980 train_time:161ms step_avg:80.44ms tok_s:138965
step:3/600 train_loss:5.8861 train_time:264ms step_avg:87.93ms tok_s:159471
step:4/600 train_loss:5.5645 train_time:369ms step_avg:92.26ms tok_s:155946
step:5/600 train_loss:5.3006 train_time:473ms step_avg:94.58ms tok_s:158048
step:6/600 train_loss:5.1711 train_time:578ms step_avg:96.35ms tok_s:156050
step:7/600 train_loss:5.0503 train_time:683ms step_avg:97.60ms tok_s:156126
step:8/600 train_loss:4.8847 train_time:789ms step_avg:98.66ms tok_s:154921
step:9/600 train_loss:4.8245 train_time:895ms step_avg:99.45ms tok_s:155215
step:10/600 train_loss:4.7318 train_time:999ms step_avg:99.91ms tok_s:157807
step:30/600 train_loss:4.3482 train_time:3125ms step_avg:104.17ms tok_s:154453
step:60/600 train_loss:3.9330 train_time:6384ms step_avg:106.41ms tok_s:149161
step:90/600 train_loss:3.9849 train_time:9638ms step_avg:107.09ms tok_s:150828
step:120/600 train_loss:3.7337 train_time:12990ms step_avg:108.25ms tok_s:144077
step:150/600 train_loss:3.6584 train_time:16559ms step_avg:110.40ms tok_s:143960
step:180/600 train_loss:3.8636 train_time:19980ms step_avg:111.00ms tok_s:147398
step:210/600 train_loss:3.6241 train_time:23282ms step_avg:110.87ms tok_s:146689
step:240/600 train_loss:3.7219 train_time:26577ms step_avg:110.74ms tok_s:144370
step:270/600 train_loss:3.3493 train_time:30005ms step_avg:111.13ms tok_s:138485
step:300/600 train_loss:3.2251 train_time:33784ms step_avg:112.61ms tok_s:140704
step:330/600 train_loss:3.4102 train_time:37117ms step_avg:112.48ms tok_s:150903
step:360/600 train_loss:3.3108 train_time:40369ms step_avg:112.14ms tok_s:150449
step:390/600 train_loss:3.3791 train_time:43673ms step_avg:111.98ms tok_s:146528
step:420/600 train_loss:3.2212 train_time:47004ms step_avg:111.91ms tok_s:148841
step:450/600 train_loss:3.4855 train_time:50346ms step_avg:111.88ms tok_s:146439
step:480/600 train_loss:3.3437 train_time:53699ms step_avg:111.87ms tok_s:150634
step:510/600 train_loss:3.2671 train_time:56959ms step_avg:111.68ms tok_s:152075
step:540/600 train_loss:3.2567 train_time:60219ms step_avg:111.52ms tok_s:151266
step:570/600 train_loss:3.3860 train_time:63581ms step_avg:111.55ms tok_s:134286
step:600/600 train_loss:3.2363 train_time:66962ms step_avg:111.60ms tok_s:150083
step:600/600 val_loss:3.2542 val_bpb:1.9498 train_time:70132ms step_avg:116.89ms
saved_model:logs/loop08_exp09_persistent8_shared3_mlx_model.npz bytes:2336730
serialized_model_int8_zlib:964593 bytes (payload:1045552 raw_pickle:1048457 payload_ratio:2.23x)
final_int8_zlib_roundtrip val_loss:3.2549 val_bpb:1.9501 eval_time:2751ms
final_int8_zlib_roundtrip_exact val_loss:3.25485134 val_bpb:1.95013354

## hypothesis

Persistent memory may repair part of the quality loss in the best size-aware shared-depth stack.

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

Partially supported. It remains far behind the best quality stack, but it is a credible quality/bytes hybrid because it preserves a sub-1MB artifact while improving the shared-depth family.
