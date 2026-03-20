# Loop 08 Experiment 07: PKO32 + AltCheap8 + Value + Budget-Matched SwiGLU

## command

logs/loop08_exp07_swiglu_best.txt
run_id:loop08_exp07_swiglu_best
mlx_version:0.29.3
train_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_train_*.bin
val_loader:shards pattern=/Users/tony/dev/parameter-golf/data/datasets/fineweb10B_sp1024/fineweb_val_*.bin tokens:1048576
WARNING: val_loader:subset enabled requested_val_max_tokens:1048576 effective_tokens:1048576 full_tokens:62021632
WARNING: train_loader:subset dataset:fineweb10B_sp1024 train_shards:80/195 new epochs will arrive sooner than the full dataset
tokenizer_path:/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
model_params:1188384 vocab_size:1024 layers:8 unique_blocks:8 dim:128 heads:4 kv_heads:2 seq_len:512 tie_embeddings:False
cheap_blocks:enabled every:2 offset:1 cheap_block_mlp_mult:0
bigram_hash:enabled vocab:2048 bos_id:1
value_embed:enabled
partial_key_offset_dims:32
mlp_kind:swiglu
iterations:600 train_batch_tokens:16384 grad_accum_steps:1 microbatch_tokens:16384 microbatch_batch_size:32 val_batch_size:65536 warmup_steps:40 max_wallclock_seconds:0.000
mlx_max_microbatch_tokens:8192
optimizer:muon+adam muon_matrix_params:44 scalar_params:33 embed_lr:0.0375 matrix_lr:0.03 scalar_lr:0.03 muon_momentum:0.95 muon_steps:7
val_bpb:enabled tokenizer_kind=sentencepiece tokenizer_path=/Users/tony/dev/parameter-golf/data/tokenizers/fineweb_1024_bpe.model
compute_dtype:mlx.core.bfloat16 compile:True
dtypes tok_emb:mlx.core.bfloat16 linear_weight:mlx.core.float32 skip_weights:mlx.core.float32
warmup_step:10/40
warmup_step:20/40
warmup_step:30/40
warmup_step:40/40
step:1/600 train_loss:6.9341 train_time:18ms step_avg:18.07ms tok_s:906711
step:2/600 train_loss:6.8659 train_time:80ms step_avg:40.20ms tok_s:263648
step:3/600 train_loss:5.8640 train_time:140ms step_avg:46.56ms tok_s:277580
step:4/600 train_loss:5.4532 train_time:199ms step_avg:49.70ms tok_s:278090
step:5/600 train_loss:5.3260 train_time:259ms step_avg:51.70ms tok_s:275410
step:6/600 train_loss:5.1459 train_time:318ms step_avg:53.04ms tok_s:275037
step:7/600 train_loss:5.0656 train_time:377ms step_avg:53.90ms tok_s:278349
step:8/600 train_loss:4.9369 train_time:436ms step_avg:54.51ms tok_s:279619
step:9/600 train_loss:4.8901 train_time:495ms step_avg:55.05ms tok_s:276895
step:10/600 train_loss:4.7944 train_time:555ms step_avg:55.47ms tok_s:277026
step:30/600 train_loss:4.3422 train_time:1757ms step_avg:58.56ms tok_s:269184
step:60/600 train_loss:3.8864 train_time:3569ms step_avg:59.49ms tok_s:269910
step:90/600 train_loss:3.9180 train_time:5395ms step_avg:59.94ms tok_s:270699
step:120/600 train_loss:3.6322 train_time:7206ms step_avg:60.05ms tok_s:271764
step:150/600 train_loss:3.5642 train_time:9016ms step_avg:60.11ms tok_s:273163
step:180/600 train_loss:3.7895 train_time:10831ms step_avg:60.17ms tok_s:270726
step:210/600 train_loss:3.5595 train_time:12654ms step_avg:60.26ms tok_s:251301
step:240/600 train_loss:3.6598 train_time:14467ms step_avg:60.28ms tok_s:272183
step:270/600 train_loss:3.3062 train_time:16280ms step_avg:60.30ms tok_s:270723
step:300/600 train_loss:3.1616 train_time:18098ms step_avg:60.33ms tok_s:273201
step:330/600 train_loss:3.3524 train_time:19925ms step_avg:60.38ms tok_s:270729
step:360/600 train_loss:3.2484 train_time:21784ms step_avg:60.51ms tok_s:257813
step:390/600 train_loss:3.3012 train_time:23641ms step_avg:60.62ms tok_s:267474
step:420/600 train_loss:3.1573 train_time:25479ms step_avg:60.66ms tok_s:267229
step:450/600 train_loss:3.4328 train_time:27314ms step_avg:60.70ms tok_s:271044
step:480/600 train_loss:3.2847 train_time:29143ms step_avg:60.72ms tok_s:272427
step:510/600 train_loss:3.2252 train_time:30968ms step_avg:60.72ms tok_s:267765
step:540/600 train_loss:3.2098 train_time:32852ms step_avg:60.84ms tok_s:266767
step:570/600 train_loss:3.3516 train_time:34739ms step_avg:60.95ms tok_s:261549
step:600/600 train_loss:3.2054 train_time:36601ms step_avg:61.00ms tok_s:257866
step:600/600 val_loss:3.2166 val_bpb:1.9272 train_time:37638ms step_avg:62.73ms
saved_model:logs/loop08_exp07_swiglu_best_mlx_model.npz bytes:3723426
serialized_model_int8_zlib:1603572 bytes (payload:1740928 raw_pickle:1746395 payload_ratio:2.13x)
final_int8_zlib_roundtrip val_loss:3.2171 val_bpb:1.9275 eval_time:793ms
final_int8_zlib_roundtrip_exact val_loss:3.21707010 val_bpb:1.92749703

## hypothesis

Replacing relu^2 with a budget-matched SwiGLU may improve MLP expressivity without needing a larger hidden state.

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

Not supported. Budget-matched SwiGLU regressed relative to the anchor, which suggests the current relu^2 MLP is already well-matched to this tiny stack or the width trade was too aggressive.
