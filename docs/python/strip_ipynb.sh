#!/usr/bin/env bash

# ipynb 内の出力結果を消去
set -euo pipefail

# 見つかった ipynb をインプレースで出力クリア
find . -type f -name "*.ipynb" -print0 | while IFS= read -r -d '' nb; do
  jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace "$nb"
done

