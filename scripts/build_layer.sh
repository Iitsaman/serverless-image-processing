#!/bin/bash
set -euo pipefail
echo "🚀 Building Lambda Layer with Pillow using Docker..."

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"
TERRAFORM_DIR="$PROJECT_DIR/terraform"

mkdir -p "$TERRAFORM_DIR"

# Build the layer using Docker 

docker run --rm \
  --platform linux/amd64 \
  -v "$TERRAFORM_DIR":/output \
  python:3.12-slim \
  bash -c "
    echo '📦 Installing Pillow for Linux AMD64...' && \
    pip install --quiet Pillow==10.4.0 -t /tmp/python/lib/python3.12/site-packages/ && \
    cd /tmp && \
    echo '📦 Creating layer zip file...' && \
    apt-get update -qq && apt-get install -y -qq zip > /dev/null 2>&1 && \
    zip -q -r pillow_layer.zip python/ && \
    cp pillow_layer.zip /output/ && \
    echo '✅ Layer built successfully for Linux (Lambda-compatible)!'
  "

echo "📍 Location: $TERRAFORM_DIR/pillow_layer.zip"
echo "✅ Layer is now compatible with AWS Lambda on all platforms!"




# window command bash ./scripts/build_layer.sh