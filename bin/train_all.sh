#!/usr/bin/env bash

# RUN every element in the blocks in parallel ! Remove `&` at the end if don't
# want all in parallel

logger="train_all.out"
for loss in betaH VAE #factor btcvae betaB
do
    echo " " >> $logger
    echo $loss >> $logger
    for dataset in celeba dsprites chairs mnist
    do
        echo $dataset >> $logger
        python main.py "$loss"_"$dataset" -x "$loss"_"$dataset"  --no-progress-bar &
    done
    wait
done

echo "best_celeba" >> $logger
python main.py best_celeba -x best_celeba --no-progress-bar

