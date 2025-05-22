# システム情報の利用

## 現在時刻・日付の表示 `date`、`cal`

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

## 待機コマンド `sleep`

- `sleep`: 指定した時間だけ処理を停止

```bash
$ sleep 5      # 5秒待つ
$ sleep 1m     # 1分待つ（m=minutes）
$ sleep 2h     # 2時間待つ（h=hours）
```

## 計測コマンド `time`

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

## ユーザー情報の取得 `id`、`groups`

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

## システム情報の取得 `w`、`last`、`top`

- `w`: 現在ログイン中のユーザーとその稼働状況を表示す
- `last`: 過去にログインしたユーザーの履歴を表示
- `top`: プロセスの使用率（CPUやメモリ）などをリアルタイムに監視

```bash
$ w
$ last
$ top
```

## ストレージ情報の取得 `df`、`du`、`ls -l`

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

## 管理者権限とパッケージ管理 `sudo`、`apt`、`yum`

`sudo` は管理者（root）権限でコマンドを実行するためのコマンドです。
`apt`（Debian系）や `yum`（RHEL系）はパッケージ管理システムのCLIで、ソフトウェアのインストールやアップデートを行います。

```bash
# 例: aptリポジトリの情報を更新し、tmuxをインストール
$ sudo apt update
$ sudo apt install tmux
```

### アプリ導入時の注意事項

- 共有サーバでは原則として `sudo` は使えません。必要な場合はサーバ管理者に相談してください。
- 生のソースファイルをダウンロードしてビルドする場合は、提供元の信頼性をよく確認してインストールするようにしましょう。

## 共有サーバ利用の心得

- 他ユーザーの計算に影響しないよう、メモリやCPUを占有しすぎないように注意しましょう
- 利用が終わったら `logout` や `exit` でセッションを終了しましょう
- 特にCIDASシステムの場合は上記に加え:
  - `scplatform`ではログイン関係の作業以外を行わないでください
  - `scfront`で重い作業は行わず、IDLノード・計算ノードへログインして行ってください
