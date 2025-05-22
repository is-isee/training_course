# シェルスクリプト 〜再現可能なシェル操作〜

一連のコマンドを `.sh` ファイルにまとめることで、作業の再現性確保と自動化が実現できます。

## 基本要素

- **コマンド**: 基本的には対話型シェルのコマンドを並べたものがシェルスクリプト
- **変数と配列**: シェル変数および環境変数が利用可能
- **制御文**: `if`、`for`、`while`

## 例: 連番ファイルを生成するスクリプト

以下のようなファイルを`make_files.sh`として作成します。

```bash
#!/usr/bin/env bash

# `seq -w` はゼロ埋め（01, 02, ..., 10）を行う。
for i in $(seq -w 1 10); do
  touch file_$i.txt
done
```

実行方法は以下のとおりです。

```bash
$ vi make_files.sh
$ chmod +x make_files.sh
$ ./make_files.sh
```

先頭の`#!/usr/bin/env bash`は、現在の`PATH`から`bash`コマンドを検索しその`bash`コマンドを通してこのスクリプトを実行することを、OSに伝えるための記述です。

## 例: ディレクトリの配列を作成し、各ディレクトリで同じ動作を行うスクリプト

```bash
#!/usr/bin/env bash

# ディレクトリの配列を定義
dirs=("run001" "run002" "run003")

# ディレクトリの配列を定義(上と同等)
dirs=()
dirs+=("run001")
dirs+=("run002" "run003")

# 各ディレクトリで処理を実行
for dir in "${dirs[@]}"; do
  mkdir -p $dir
  cd $dir
  ls -l  # ここに実行したい処理を記述
  cd -
done
```

## 例: ネットワークごしに複数コマンドを実行するスクリプト

```bash
#!/usr/bin/env bash

# `-t`: 端末が疑似端末でない場合特有のエラーを防止(大抵は不要)
ssh -t user@remote <<EOF
pwd
ls -l
date
EOF
```

## ワンライナー 〜複数のコマンドを一行で〜

複数のコマンドを1行にまとめて書くことで、簡単な処理をスクリプト化せずに実行できます。

```bash
$ cmd1 ; cmd2 ; cmd3    # 各コマンドを順に実行（失敗しても続行）
$ cmd1 && cmd2 && cmd3  # 前のコマンドが成功したら次を実行 (失敗した時点で停止)
```

## **演習**: CIDASシステムへのバッチジョブ投入

- [CIDASシステム利用マニュアル](https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:ja:manual:cidas:start)を良く読んで、IDLノード上でバッチジョブを実行しましょう。
