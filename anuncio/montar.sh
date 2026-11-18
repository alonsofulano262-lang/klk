#!/usr/bin/env bash
# Uso: ./montar.sh clip_cafe.mp4  ->  meridiano_final_15s.mp4
# Plano 1: tu clip (7,5 s, 9:16). Plano 2: cartel Meridiano (7,5 s). Corte suave, sin subtítulos.
set -e
CLIP="$1"; DIR="$(cd "$(dirname "$0")" && pwd)"
ffmpeg -y -i "$CLIP" -i "$DIR/plano2_cartel.mp4" -filter_complex \
"[0:v]trim=0:7.8,setpts=PTS-STARTPTS,fps=30,scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1[a];\
[1:v]fps=30,setsar=1[b];[a][b]xfade=transition=fade:duration=0.3:offset=7.5,trim=0:15,format=yuv420p[v]" \
-map "[v]" -an -c:v libx264 -crf 17 "$DIR/../meridiano_final_15s.mp4"
