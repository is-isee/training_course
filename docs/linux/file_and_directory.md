# ファイル・ディレクトリの操作

## Linux では「すべてはファイル」

Linuxでは、デバイスやプロセス情報、設定インタフェースなど、あらゆるリソースが「ファイル」として表現されます

- 通常のファイルやディレクトリ
- `/dev/null` や `/dev/sda1`（デバイス）
- `/proc/cpuinfo`（CPU情報）
- ソケットファイルやパイプ

そのため、ファイル操作はLinuxにおいて本質的な役割を果たします。とは言え、直接ファイルを触ると煩雑でヒューマンエラーの危険があるため、実際にデバイスを扱う場合は専用のコマンドを使うことが大半です。

## ファイルの一覧を取得 `ls`

```bash
ls             # 現在のディレクトリの一覧
ls -l          # 詳細表示
ls -a          # 隠しファイル（.で始まる）を含めて表示
ls -lh         # サイズを人間に読みやすい単位で表示
```

## ワイルドカード `*`、`?`、`[ ]`、`[! ]`

- `*` : 任意の長さの文字列にマッチ
- `?` : 任意の1文字にマッチ
- `[a-c]` : aからcまでの任意の1文字にマッチ
- `[3-9]` : 3から9までの任意の1文字にマッチ
- `[^a-c]` : aからcまでの文字以外の任意の1文字にマッチ
- **注意**: 正規表現とは異なるパターンマッチのルールで、**グロブ**（glob）とも呼ばれます

## 今どこにいるの？ `pwd`

```bash
pwd  # カレントディレクトリ（作業中の場所）を表示
```

## パスの読み方

- パス: ファイルやディレクトリの場所を示す文字列
- 絶対パス: ルート(`/`)からの完全なパス `/home/user/project`
- 相対パス: 現在地から見た相対的なパス
  - 例: 現在地が `/home/user/project` の場合、現在地から見た `/home/user/other` の相対パスは `../other`
- 主な記号と意味
  - `.`: 現在のディレクトリ
  - `..`: 親ディレクトリ (一つ上のディレクトリ)
  - `~`: ユーザーのホームディレクトリ (環境変数 `HOME` に展開される)

## ディレクトリの移動 `cd`

```bash
$ cd /path/to/dir
$ cd ..       # 親ディレクトリへ
$ cd -        # 直前のディレクトリに戻る
$ cd          # 何もつけなければホームディレクトリに戻る
```

## 標準出力・標準入力・標準エラー出力

UNIXでは、端末やファイルとのやりとりもすべてファイルを介して行われます。

- 標準出力（stdout）: ファイル記述子 1
- 標準エラー出力（stderr）: ファイル記述子 2
- 標準入力（stdin）: ファイル記述子 0

```bash
$ echo "Hello, world!"  # 標準出力に Hello, world!
$ ls no_such_file.txt   # 標準エラー出力に No such file or directory
```

## パイプとリダイレクト

- パイプ: `|` を使って、出力を次のコマンドの入力へ渡す
- リダイレクト: `>`（上書き）、`>>`（追記）、`2>`（標準エラー）など

```bash
$ ls
$ ls -l | grep a
$ ls non_such_file.txt 2> error.log
```

## 空ファイルの作成 `touch`

本来はファイルの最終アクセス日時を更新するためのコマンドですが、空ファイルの作成に良く使われます。

```bash
$ touch newfile.txt
```

## ディレクトリの作成・削除 `mkdir` `rmdir`

```bash
$ mkdir newdir
$ mkdir -p parent/child/grandchild  # 再帰的にディレクトリを作成
$ rmdir newdir                      # 空でないと失敗する
```

## ファイル・ディレクトリの削除 `rm`

```bash
$ rm file.txt
$ rm -r directory/     # ディレクトリを再帰的に削除
```

## ファイル・ディレクトリのコピー・移動 `cp`、`mv`

```bash
$ cp source.txt dest.txt
$ cp -r src_dir/ dest_dir/   # ディレクトリを再帰的にコピー

$ mv oldname.txt newname.txt
$ mv file.txt ~/             # 移動
```

## ファイルの検索 `find`

```bash
# 現在のディレクトリ以下でファイル名が *.txt にマッチするファイルを検索
$ find . -name "*.txt"

# /path 以下のファイル(ディレクトリは除く)のうちサイズが10MB以上のものを検索
$ find /path -type f -size +10M
```

## ファイル・ディレクトリの容量 `ls -lh`、`du -hs`

```bash
$ ls -lh           # サイズ表示
$ du -hs folder/   # ディレクトリの合計サイズ
```

## アクセスの権限の確認 `ls -l`

Linuxでは、ファイルやディレクトリに対して「誰が」「何をできるか」というアクセス権限（パーミッション）が設定されています。`ls -l`でアクセス権限を確認できます。

```bash
$ ls -l
-rw-r--r-- 1 user user  1234 Apr  7 12:34 example.txt
```

この例の左端にある `-rw-r--r--` がパーミッション情報:

- 最初の文字: ファイルの種類  
  - `-` は通常ファイル、`d` はディレクトリ、`l` はシンボリックリンクなど  
- その後ろの9文字: `[所有者][グループ][その他]` に対する読み書き実行の許可  
  - `r`（read）: 読み取り  
  - `w`（write）: 書き込み  
  - `x`（execute）: 実行（ディレクトリの場合は「中に入れる」）
  - 上の例では、所有者がread/write、所有者と同じグループのユーザがread、その他のユーザがreadできる
- 実行権限の意味
  - 実行権限があるとファイルをコマンドのように実行できる (例: `./script.sh`)
    - 実際、`PATH`にあるコマンドのいくつかはシェルスクリプト(テキストファイル)
  - ディレクトリに対しての `x` は「ディレクトリ内を閲覧・移動できる」という意味

## アクセスの権限の変更 `chmod`

```bash
$ chmod 644 file.txt        # 所有者に rw-、その他に r--
$ chmod -R u-w scripts/     # 所有者の書き込み権限を再帰的に削除
$ chmod a+x run.sh          # 全員に実行権限を追加
```

- 数値による権限の指定:
  - `r`は4、`w`は2、`x`は1が割り当てられ、その総和の数値で権限を表現
    - 例: 7 (= 4 + 2 + 1) はread/write/executeの全てを許可
    - 例: 5 (= 4 + 1) はread/executeを許可、writeは禁止
  - `777`: 誰でも読み書き実行できる（危険）
  - `755`: 所有者が rwx、それ以外は rx（よくあるディレクトリ設定）
  - `644`: 所有者が rw、それ以外は r（テキストファイルに多い）
- 記号による権限の指定:
  - `u`（user: 所有者）、`g`（group）、`o`（others）、`a`（all）
  - `+`（追加）、`-`（削除）、`=`（明示的に設定）

## シンボリックリンク `ln -s`

- いわゆるショートカットの作成

```bash
$ ln -s target.txt link.txt
```

## ファイルの圧縮・アーカイブ `zip`、`unzip`、`tar`

```bash
$ zip archive.zip file1 file2
$ unzip archive.zip

$ tar -cvf archive.tar folder/  # アーカイブの作成
$ tar -xvf archive.tar          # アーカイブの展開
```

## **演習**: 色々なファイル操作

- 隠しファイルを含むファイル一覧を表示しましょうい
- 空のファイルを3つ作成し、まとめて削除しましょう
- `~/dir1/hello.txt` を作り、`~/dir2/hello.txt` へシンボリックリンクを貼りましょう
