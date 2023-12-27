#!/bin/bash

set -e

vols="-v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro"
vols+=" -v /nfs1:/nfs1 -v /nfs2:/nfs2"
vols+=" -v $HOME:$HOME"
vols+=" -v /cephfs:/cephfs"

vols+=" -v $PWD/..:/app -w /app/$(basename $PWD)"

# vols+=" -v /nfs1/yichao.hu:/data -v /home/yichao.hu/nltk_data:/root/nltk_data"
# vols+=" -v `pwd`:/workspace/TTS-FastSpeech"

vols+=" -e TORTOISE_MODELS_DIR=/serving_models"
vols+=" -v /nfs2/speech/model/tts/tortoise-tts/serving_models:/serving_models"
vols+=" -v `pwd`/remote/results:/results"
# vols+=" -v /home/tmp-yichao.hu/.cache/huggingface:/root/.cache/huggingface"
vols+=" -v /nfs2/guang.liang/models/huggingface:/root/.cache/huggingface"
vols+=" -v `pwd`:/workspace/tortoise-tts"
# vols+=" -v /nfs2/speech/yichao.hu/workspace/tortoise_tts/voices_exp:/voices"
vols+=" -v /nfs2/speech/yichao.hu/workspace/tortoise_tts/voices_exp:/voices"

ports=" -p 8865:8765 -p 8866:8766"

name=gl-tts-tortoise
image=sh-harbor.mthreads.com/mt-ai/tts:tortoise_v1.1

echo "Start docker container: ${name}"
# docker run -d -it --name ${name} --shm-size 40g --rm --user "$(id -u)":"$(id -g)" $vols $ports $image bash
docker run -d -it --name ${name} --shm-size 40g --rm $vols $ports $image bash

# echo "Add user in docker container: ${USER} => ${name}"
# docker exec --user root -t ${name} sh -c 'groupadd -g 452200513 domain;
#   useradd -u 452222195 guang.liang -g 452200513 -s /bin/bash;
#   chown -R 452222195:452200513 .;'

echo "Docker container started: ${name}"

