#!/usr/bin/env bash

POSE2D=${POSE2D:-"configs/body_2d_keypoint/rtmpose/coco/rtmpose-t_8xb256-420e_aic-coco-256x192.py"}
POSE2DWEIGHTS=${POSE2DWEIGHTS:-"rtmpose-tiny_simcc-aic-coco_pt-aic-coco_420e-256x192-cfc8f33d_20230126.pth"}
DETMODEL=${DETMODEL:-"projects/rtmpose/rtmdet/person/rtmdet_nano_320-8xb32_coco-person.py"}
DETWEIGHTS=${DETWEIGHTS:-"rtmdet_nano_8xb32-100e_coco-obj365-person-05d8511e.pth"}

DATA_DIR="/data/mmpose/tests/yd_data_test"

for entry in "$DATA_DIR"/*; do
    if [ -d "$entry" ]; then
        dirname=$(basename "$entry")
        echo "$dirname"
        PREDOUTDIR=${OUTDIR:-"output/$dirname/predictions"}
        VISOUTDIR=${OUTDIR:-"output/$dirname/images"}
        python demo/inferencer_demo.py \
            $entry \
            --pose2d=$POSE2D \
            --pose2d-weights=$POSE2DWEIGHTS \
            --det-model=$DETMODEL \
            --det-weights=$DETWEIGHTS \
            --draw-bbox \
            --vis-out-dir=$VISOUTDIR \
            --pred-out-dir=$PREDOUTDIR
    fi
done

