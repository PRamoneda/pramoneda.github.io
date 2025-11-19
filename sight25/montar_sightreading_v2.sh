#!/usr/bin/env bash
set -euo pipefail

# --- Comprobaciones ---
if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "FFmpeg no está instalado. En Ubuntu: sudo apt update && sudo apt install -y ffmpeg"
  exit 1
fi

if [ "$#" -lt 6 ]; then
  echo "Uso: $0 IMG_EASY VID_EASY IMG_MED VID_MED IMG_DIFF VID_DIFF [SALIDA.mp4]"
  echo "Ejemplo:"
  echo "  $0 easy.png easy.mp4 medium.png medium.mp4 difficult.png difficult.mp4 salida.mp4"
  exit 1
fi

IMG_E="$1"; VID_E="$2"
IMG_M="$3"; VID_M="$4"
IMG_D="$5"; VID_D="$6"
OUT="${7:-sightreading_compilado.mp4}"

# --- Ajustes ---
WIDTH=1920
HEIGHT=1080
PIP_W=480
MARGIN=30
TITLE_DUR=2
TARGET_FPS=30
FONTFILE="/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"

exists() { if [ ! -f "$1" ]; then echo "No existe: $1"; exit 1; fi; }
exists "$IMG_E"; exists "$VID_E"
exists "$IMG_M"; exists "$VID_M"
exists "$IMG_D"; exists "$VID_D"

# --- Funciones ---
make_title() {
  local label="$1"
  local out="$2"
  ffmpeg -y \
    -f lavfi -t "$TITLE_DUR" -i "color=c=black:s=${WIDTH}x${HEIGHT}" \
    -f lavfi -t "$TITLE_DUR" -i "anullsrc=channel_layout=stereo:sample_rate=48000" \
    -vf "drawtext=fontfile=${FONTFILE}:text=Sight-reading Exercise \(${label}\):fontcolor=white:fontsize=64:x=w/2-text_w/2:y=h/2-text_h/2,format=yuv420p,fps=${TARGET_FPS}" \
    -c:v libx264 -preset medium -crf 18 -pix_fmt yuv420p \
    -c:a aac -b:a 192k -ar 48000 -ac 2 \
    -shortest "$out"
}

make_pair() {
  local img="$1"; local vid="$2"; local out="$3"
  ffmpeg -y -loop 1 -i "$img" -i "$vid" \
    -filter_complex "[0:v]scale=${WIDTH}:${HEIGHT}:force_original_aspect_ratio=decrease,pad=${WIDTH}:${HEIGHT}:(ow-iw)/2:(oh-ih)/2:black,setpts=PTS-STARTPTS[bg]; \
                     [1:v]setpts=PTS-STARTPTS,scale=${PIP_W}:-2:flags=lanczos[small]; \
                     [bg][small]overlay=x=W-w-${MARGIN}:y=H-h-${MARGIN}:format=auto,format=yuv420p,fps=${TARGET_FPS}[v]" \
    -map "[v]" -map 1:a? \
    -c:v libx264 -preset medium -crf 18 -pix_fmt yuv420p \
    -c:a aac -b:a 192k -ar 48000 -ac 2 \
    -shortest "$out"
}

# --- Generación de segmentos ---
make_title "easy"      "01_title_easy.mp4"
make_pair  "$IMG_E" "$VID_E" "02_pair_easy.mp4"
make_title "medium"    "03_title_medium.mp4"
make_pair  "$IMG_M" "$VID_M" "04_pair_medium.mp4"
make_title "difficult" "05_title_difficult.mp4"
make_pair  "$IMG_D" "$VID_D" "06_pair_difficult.mp4"

# --- Lista para concat ---
cat > inputs.txt <<EOF
file '01_title_easy.mp4'
file '02_pair_easy.mp4'
file '03_title_medium.mp4'
file '04_pair_medium.mp4'
file '05_title_difficult.mp4'
file '06_pair_difficult.mp4'
EOF

# --- Concatena y RE-CODIFICA a un solo archivo consistente ---
ffmpeg -y -f concat -safe 0 -i inputs.txt \
  -c:v libx264 -preset medium -crf 18 -r ${TARGET_FPS} -pix_fmt yuv420p \
  -c:a aac -b:a 192k -ar 48000 -ac 2 \
  "$OUT"

echo "Listo: $OUT"
