stage=1

if [ $stage -le 0 ]; then
    mkdir score
    mkdir -p score/tmp score/clean
    rm -rf score/tmp score/clean
    mkdir score/tmp score/clean

    echo "##############################"
    echo "##Cutting wav data by 10 min##"
    echo "##############################"

    ffmpeg -i $1 -f segment -segment_time 60 -c copy score/tmp/out%03d.wav
    ffmpeg -i $2 -f segment -segment_time 60 -c copy score/clean/out%03d.wav
    
    echo "Stage 0: $1 and $2 are sccessfuly cut."
fi

if [ $stage -le 1 ]; then
    echo "################"
    echo "##Scoring PESQ##"
    echo "################"

    for ref in score/clean/*
    do
        for deg in score/tmp/*
        do
            if [[ -f $file ]]; then
              python3 score_pesq.py $ref $deg 
            fi
        done
    done

echo "Stage1: DONE!"
fi

if [ $stage -le 1 ]; then
    echo "###############"
    echo "##Scoring WER##"
    echo "###############"

fi