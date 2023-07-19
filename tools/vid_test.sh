#!/usr/bin/env bash

POSE2D=${POSE2D:-"projects/rtmpose/rtmpose/body_2d_keypoint/rtmpose-t_8xb256-420e_coco-256x192.py"}
POSE2DWEIGHTS=${POSE2DWEIGHTS:-"rtmpose-tiny_simcc-aic-coco_pt-aic-coco_420e-256x192-cfc8f33d_20230126.pth"}
DETMODEL=${DETMODEL:-"projects/rtmpose/rtmdet/person/rtmdet_nano_320-8xb32_coco-person.py"}
DETWEIGHTS=${DETWEIGHTS:-"rtmdet_nano_8xb32-100e_coco-obj365-person-05d8511e.pth"}

DATA_DIR="tests/yd_data_test/"

# 遍历目录树
find "$DATA_DIR" -type f | while read file; do
    # 判断文件是否以.mp4结尾
    if [[ "$file" == *.mp4 ]]; then
        echo "$file is an mp4 file"
        filename=$(basename "$file")
        filename_no_ext="${filename%.*}"
        PREDOUTDIR=${OUTDIR:-"output/$filename_no_ext/predictions"}
        VISOUTDIR=${OUTDIR:-"output/$filename_no_ext/video_result"}
        python demo/inferencer_demo.py \
            $file \
            --pose2d=$POSE2D \
            --pose2d-weights=$POSE2DWEIGHTS \
            --det-model=$DETMODEL \
            --det-weights=$DETWEIGHTS \
            --draw-bbox \
            --vis-out-dir=$VISOUTDIR \
            --pred-out-dir=$PREDOUTDIR
    else
        echo "$file is not an mp4 file"
    fi
done
echo "no way"

