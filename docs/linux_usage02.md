# Linux入門(2): プロセス、システム、発展的な話題

## プロセス

### Linuxのプロセスツリー

Linuxでは、すべてのプロセスは1つの親プロセスから派生しており、ツリー状の構造になっています。

- 各プロセスには固有のプロセスID（PID）が付与されます。
- 親プロセスが必ず存在し、プロセス間で環境変数などが引き継がれます。

```bash
$ ps           # プロセスの一覧を表示
$ ps -f        # フル形式で親子関係を含めて表示
$ pstree       # プロセスのツリー構造を表示
```

よく見るプロセスの例:

- 対話型シェル（bash など）
- 実行中のコマンド（ls, cat, sleep など）
- デーモン（バックグラウンドサービス）

### フォアグラウンドとバックグラウンドの切り替え `jobs`、`fg`、`bg`、`Ctrl-Z`

ターミナルで起動したプロセスは通常「フォアグラウンド」で動作します。

- `Ctrl-Z`: 現在のジョブを一時停止
- `bg`: 停止中のジョブをバックグラウンドで再開
- `fg`: ジョブをフォアグラウンドに戻す
- `jobs`: ジョブの一覧を表示

```bash
$ sleep 100
# 100秒以内にCtrl-Z で停止
$ jobs
$ bg           # バックグラウンドで再開
$ jobs
$ fg           # フォアグラウンドに戻す

$ sleep 100 &  # コマンドの最後に&をつけると最初からバックグラウンド
$ jobs
```

### リモートでプロセスの実行を続けるには `nohup`、`screen`、`tmux`

リモート接続（SSHなど）を切ってもプロセスを生かしたい場合は、次のいずれかの方法で実現できます。

まず、`nohup`を使うとログアウト後もプロセスを継続できる。

```bash
client$ ssh <server_name>
$ bash -c "sleep 30 && echo Finished at `date` > tmp.txt" &
$ exit    # ログアウトするとスクリプトの実行プロセスは途中で停止

client$ ssh <server_name>
$ nohup bash -c "sleep 30 && echo Finished at `date` > tmp.txt" &
$ exit    # 30秒以内にログアウトしてもプロセスは継続
client$ ssh <server_name>
$ cat tmp.txt
```

`screen`や`tmux`はターミナルマルチプレクサと呼ばれ、リモート接続切断後もプロセス維持できます。分割画面や切断したセッションへの再接続も可能です。

```bash
$ tmux           # 新しいセッションを開始
$ tmux attach    # 切断したセッションに再接続
```

#### `scfront`上で重い処理を実行しない

`scfront`は重い処理を実行することを想定されておらず、`screen`や`tmux`はインストールされていません。実際にデータ解析や数値シミュレーションを実行する場合はIDLノードや計算ノードを利用してください。

### プロセスの確認・停止・強制終了 `ps`、`kill`、`killall`

```bash
$ ps aux                # 詳細なプロセス一覧
$ ps l -u <user>        # <user>が実行したプロセス一覧

$ kill <PID>            # 対象プロセスを終了
$ kill -9 <PID>         # 強制終了（SIGKILL）

$ killall <process>     # 名前が <process> のプロセスを全て終了
$ killall -9 <process>  # 名前が <process> のプロセスを全て強制終了
```

プロセスの状態を確認しながら、安全に停止させる習慣をつけましょう。

### プロセスの停止忘れに要注意

通常、SSH接続が切れるとそのセッションで実行したプロセスも自動で停止します。
しかし、通信切断によりSSH接続が切れた後も子プロセスが残り続け、他ユーザーの利用を妨げる場合があります。
その場合、`ps`で確認しながら手動で`kill`する必要があります。
`nohup`やターミナルマルチプレクサを利用すると、プロセスの停止を忘れる危険性は更に上がります。
できる限り正常にセッション・プロセスを終了する習慣をつけましょう。

### **演習**: プロセスの生成と削除

以下の操作を実際に試して、プロセスの生成・確認・終了の流れを体験してください。

(1) `sleep` コマンドをバックグラウンドで実行する:

```bash
$ sleep 60 &  # 60秒を計測して何もせず終了するプロセスをバックグラウンドで実行
```

(2) `ps` または `jobs` で確認する:

```bash
$ ps
$ jobs
```

(3) プロセスIDを調べて `kill` で終了させる:

```bash
$ kill <PID>
```

## システム情報

### 現在時刻・日付の表示 `date`、`cal`

- `date`: 現在の日付と時刻を表示

```bash
$ date
Mon Apr  7 15:00:00 JST 2025
```

- `cal`: 当月のカレンダーを表示

```bash
$ cal
     April 2025
Su Mo Tu We Th Fr Sa
       1  2  3  4  5
 6  7  8  9 10 11 12
...
```

### 待機コマンド `sleep`

- `sleep`: 指定した時間だけ処理を停止

```bash
$ sleep 5      # 5秒待つ
$ sleep 1m     # 1分待つ（m=minutes）
$ sleep 2h     # 2時間待つ（h=hours）
```

### 計測コマンド `time`

- `time`: コマンドの実行時間を計測

```bash
$ time ls -l
real    0m0.003s
user    0m0.001s
sys     0m0.002s
```

- `real`: 実際の経過時間
- `user`: ユーザ空間でのCPU時間 (プロセスがCPUを使った時間)
- `sys` : カーネル空間でのCPU時間 (OSがCPUを使った時間)

### ユーザー情報の取得 `id`、`groups`

- `id`: 現在のユーザーID（UID）、グループID（GID）、所属グループなどを確認

```bash
$ id
uid=1000(user) gid=1000(user) groups=1000(user),27(sudo)
```

- `groups`: 自分が所属しているグループを確認

```bash
$ groups
user sudo
```

### システム情報の取得 `w`、`last`、`top`

- `w`: 現在ログイン中のユーザーとその稼働状況を表示す
- `last`: 過去にログインしたユーザーの履歴を表示
- `top`: プロセスの使用率（CPUやメモリ）などをリアルタイムに監視

```bash
$ w
$ last
$ top
```

### ストレージ情報の取得 `df`、`du`、`ls -l`

- `df -h`: ディスク全体の使用状況を表示（`-h` は human-readable）
- `du -hs <dir>`: 指定ディレクトリの合計サイズ
- `ls -l`: 各ファイル・ディレクトリのサイズを表示（バイト単位）

```bash
$ df -h
$ du -hs ~/work
$ ls -l
```

### CIDASシステムにおけるホームディレクトリの容量制限

CIDASでは以下の容量制限（quota）があります。

- `scplatform`のホームディレクトリ: 10 MB 以下
- `scfront` や IDL・計算ノードのホームディレクトリ: 500 GB 以下
- スクラッチ領域 `/scr/`: 容量制限なし (定期的に消去されるので一時ファイル用)

現在の使用状況は、`scfront` 上で

```bash
$ uquota.sh -h
```

を実行すると確認できます。詳細は[CIDASシステム利用マニュアル](https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:ja:manual:cidas:login)を参照してください。

### 共有サーバ利用の心得

- 他ユーザーの計算に影響しないよう、メモリやCPUを占有しすぎないように注意しましょう
- 利用が終わったら `logout` や `exit` でセッションを終了しましょう
- 特にCIDASシステムの場合は上記に加え:
  - `scplatform`ではログイン関係の作業以外を行わないでください
  - `scfront`で重い作業は行わず、IDLノード・計算ノードへログインして行ってください

## 次のステップへ 〜より発展的な話題〜

### シェルスクリプト 〜再現可能なシェル操作〜

一連のコマンドを `.sh` ファイルにまとめることで、作業の再現性確保と自動化が実現できます。

#### 基本要素

- **コマンド**: 基本的には対話型シェルのコマンドを並べたものがシェルスクリプト
- **変数と配列**: シェル変数および環境変数が利用可能
- **制御文**: `if`、`for`、`while`

#### 例: 連番ファイルを生成するスクリプト

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

#### 例: ディレクトリの配列を作成し、各ディレクトリで同じ動作を行うスクリプト

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

#### 例: ネットワークごしに複数コマンドを実行するスクリプト

```bash
#!/usr/bin/env bash

# `-t`: 端末が疑似端末でない場合特有のエラーを防止(大抵は不要)
ssh -t user@remote <<EOF
pwd
ls -l
date
EOF
```

#### **演習**: CIDASシステムへのバッチジョブ投入

- [CIDASシステム利用マニュアル](https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:ja:manual:cidas:start)を良く読んで、IDLノード上でバッチジョブを実行しましょう。

### ワンライナー 〜複数のコマンドを一行で〜

複数のコマンドを1行にまとめて書くことで、簡単な処理をスクリプト化せずに実行できます。

```bash
$ cmd1 ; cmd2 ; cmd3    # 各コマンドを順に実行（失敗しても続行）
$ cmd1 && cmd2 && cmd3  # 前のコマンドが成功したら次を実行 (失敗した時点で停止)
```

### タスクランナー `Makefile`

`Makefile` は、ファイルの依存関係に基づいて再構築を効率化するための自動化ツールです。主にソースコードのコンパイルに用いられますが、データ処理や画像生成などの一般的なタスクにも応用できます。

#### 例: 分割コンパイル

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

#### 例: データ処理から画像作成までの自動化

```makefile
all: figure.png

processed.csv: process.py data.csv
        python process.py data.csv  # processed.csv を出力

figure.png: plot.py processed.csv
        python plot.py processed.csv # figure.png を出力
```

### 管理者権限とパッケージ管理 `sudo`、`apt`、`yum`

`sudo` は管理者（root）権限でコマンドを実行するためのコマンドです。
`apt`（Debian系）や `yum`（RHEL系）はパッケージ管理システムのCLIで、ソフトウェアのインストールやアップデートを行います。

```bash
# 例: aptリポジトリの情報を更新し、tmuxをインストール
$ sudo apt update
$ sudo apt install tmux
```

#### 注意事項

- 共有サーバでは原則として `sudo` は使えません。必要がある場合はサーバ管理者に相談してください。
- 生のソースファイルをダウンロードしてビルドする場合は、提供元の信頼性をよく確認してインストールするようにしましょう。

### 仮想化とコンテナ

#### 仮想化 vs コンテナ

- **ハイパーバイザ型**（VMware、VirtualBox、KVM など）
  - ハードウェアを仮想化し、ゲストOSを独立した仮想マシンとして実行
- **OSレベル仮想化（コンテナ）**（Docker、Apptainer など）
  - ホストOSの根幹部分(カーネル)を共有しつつ、プロセス空間やファイルシステムを分離
  - ハイパーバイザ型より軽量で起動も高速なため、開発環境の再現性と共有に適している

#### Docker

- 最も普及しているOSレベルのコンテナ技術
- `dockerd` デーモンを介してイメージのビルド・配布・実行を行う

#### Apptainer （旧 Singularity）

- HPC 環境で多用される非特権ユーザー実行可能なコンテナ技術
- Dockerイメージの活用も可能

#### Development Containers

- 開発環境を`json`形式の設定ファイルで定義するオープン仕様
- プロジェクト直下の `.devcontainer/` 内に、`devcontainer.json` 等を配置して環境管理
- VS Code、GitHub Codespaces、devcontainer CLIなどで同一定義の環境を起動可能
- 拡張機能、設定、ポートフォワーディング、ボリュームマウント、環境変数などを一括設定可能
