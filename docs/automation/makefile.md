# `make` と `Makefile` 〜タスクランナーとして〜

`make` は、ファイルの依存関係を記述した設定ファイル（デフォルトでは `Makefile` という名前）に基づいて、タスクの実行を自動化するツールです。主にソースコードのコンパイルに用いられますが、データ処理や画像生成など、手順が決まっている一連の作業を効率化するためにも広く活用できます。

一般に `make` という場合、多くのシステムで利用可能な GNU make を指すことがほとんどです。以下の説明では、主に GNU make の挙動を前提としています。

## `Makefile`の例: 分割コンパイル

以下の内容をファイル `Makefile` として保存しましょう。
**スペースではなくタブによるインデントが必要**なことに注意してください。

```makefile
# ファイル名ではないターゲット all は app に依存
.PHONY: all
all: app

# app は app.o に依存し、gcc で作成
# $@: ターゲット(ここでは app)
# $^: ターゲットの全ての依存先(ここでは app.o)
app: app.o
        gcc -o $@ $^

# app.o は app.c と header.h に依存
app.o: app.c header.h
        gcc -o $@ -c $^

# 中間ファイルの削除ルール
clean:
        rm -f *.o app
```

実行方法:

```bash
$ cat > header.h <<EOF
const int a = 0;
EOF

$ cat > app.c <<EOF
#include "header.h"
int main() { return a; }
EOF

$ make            # appが生成
$ make            # 2回目は何も起きない
$ touch header.h  # ヘッダを更新
$ make            # ヘッダの更新を検知して必要な処理を再実行
$ touch app.o     # オブジェクトファイルを更新
$ make            # オブジェクトファイルの更新を検知して必要な処理を再実行
$ make clean      # 中間ファイルを削除
```

## 例: データ処理から画像作成までの自動化

```makefile
all: figure.png

processed.csv: process.py data.csv
        python process.py data.csv  # processed.csv を出力

figure.png: plot.py processed.csv
        python plot.py processed.csv # figure.png を出力
```
