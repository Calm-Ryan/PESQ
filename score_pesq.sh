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
    ref="score/tmp/*"
    deg="score/clean/*"
    
    i=0
    for Path in "${ref[@]}"
    do
        python3 score_pesq.py ${Path} ${deg[i]}
        let i++
    done

echo "Scoring PESQ: DONE!"
fi