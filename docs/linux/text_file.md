# テキストファイルの操作

## テキストファイルとバイナリファイル

- ファイルとは、本質的には**バイト列（データの羅列）**です。
- 文字もデータの一種であり、文字コード（例：UTF-8, ASCII）に従って表現されます。
- **テキストファイル**とは、**文字データのみ**で構成されており、**人間が直接読める形式**のファイルを指します（例：`.txt`, `.csv`, `.py`）。
- **バイナリファイル**とは、**文字以外のデータ（画像・音声・実行ファイルなど）を含む**ファイルの総称であり、テキストとして開くと意味不明な記号が並んでいます。

## 文字コードと特殊文字に関する注意点

| 落とし穴 | 具体例 | 対策 |
| --- | --- | --- |
| **全角／半角の混在** | `ＡＢＣ.txt` と `ABC.txt` は別ファイル扱い | ファイル名・入力データは **半角（ASCII）** を原則にする |
| **全角スペース・半角スペース** | `ファイル 名.txt`（全角空白）、`file name.txt`（半角空白） | どちらも見分けにくいので **空白を避ける or "引用符" で囲む** |
| **タブ文字** | 行頭インデントがスペースかタブか不明 | エディタで「タブ可視化」設定＋ **tab → 4 space 変換** ルールを統一 |
| **不可視制御文字** | 0x1B (ESC) などが混入し、CSV 解析時にエラー | `cat -v` / `od -c` で点検、不要なら `tr -d` で除去 |
| **改行コード差** | Unix: LF (`\n`)、Windows: CRLF (`\r\n`) | Git の `core.autocrlf` を設定、`dos2unix`/`unix2dos` で変換 |
| **Unicode 正規化の揺れ** | `é` (U+00E9) vs `e`+`́` (U+0065 U+0301) | 入出力を **UTF-8 NFC** に統一、`iconv`・`uconv` で整形 |

## ファイルの種類 `file`

`file` コマンドを使うと、ファイルの種類を自動で判別できます。

```bash
$ file hello.txt
hello.txt: ASCII text

$ file image.png
image.png: PNG image data, 800 x 600, 8-bit/color RGB, non-interlaced

$ file script.py
script.py: Python script, UTF-8 Unicode text

$ file a.out
a.out: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked
```

## テキストファイルの編集 `vi`

```bash
$ vi filename.txt
```

Linuxなら大抵インストールされているため使えると便利です。

`vi` は、通常のテキストエディタと異なり、カーソル前後の文字を編集する「入力モード」とカーソルの移動やコマンドを実行する「コマンドモード」の2つのモードがあり、モードを切り替えて操作します。
最低限、以下のショートカットを覚えておきましょう。

| モード | コマンド | 内容 |
| --- | ---- | ---- |
| コマンドモード | `:q!` | 保存せず終了 |
| コマンドモード | `:wq` | 保存して終了 |
| コマンドモード | `k`, `j` | カーソルを上下に移動 |
| コマンドモード | `h`, `l` | カーソルを左右に移動 |
| コマンドモード | `x` | カーソル位置の文字を削除 |
| コマンドモード | `i` | 入力モードに入る |
| 入力モード | `<Esc>` | コマンドモードに戻る |

その他の利用方法は長くなるので各自で調べてください。
上記以外にも様々なコマンドがあり、慣れると非常に高速にテキスト編集が可能です。

## テキストファイルの閲覧 `cat, less, head, tail`

```bash
cat file.txt
less file.txt
head -n 10 file.txt
tail -f file.txt
```

- `cat` はファイルの内容を一度に最後まで表示するため:
  - 短いファイルの内容を確認する際に便利
  - 長いファイルを表示するときは画面がスクロールしてしまい、内容を確認しにくい
- `less` は長いファイルをページ送りで見る際に便利
- `tail -f` は末尾に更新が続くログファイルなどを読み続ける際に便利

## 書式付き文字列の出力 `printf`

```bash
# 標準出力に文字列を出力
$ printf "Hello World\n"
Hello World

# hello.txt に書き込み
$ printf "Hello World\n" > hello.txt
$ cat hello.txt
Hello World

# printf で変数を埋め込む
$ USER="Bob"
$ ID=123
$ printf "User: %s, ID: %d\n" "$USER" $ID
User: Bob, ID: 123

# ゼロ埋めしてファイル名を出力
$ VALUE=42
$ printf "File Name: z%04d.txt\n" $VALUE
File Name: z0042.txt
```

## テキストファイルの検索 `grep`

```bash
grep "keyword" file.txt
grep -r "pattern" ./      # ディレクトリ以下を再帰的に検索
```

`grep` コマンドでは強力な [正規表現](https://ja.wikipedia.org/wiki/正規表現)が利用可能です。
正規表現は、文字列のパターンを表現するための特殊な記法です。
詳しくは、上記の Wikipedia のリンクなどを参照してください。

## テキストファイルの置換 `sed`

```bash
$ printf 'old and new\n' > input.txt
$ cat input.txt
old and new

# input.txtのoldをnewに置換してoutput.txtに書き込み
$ sed 's/old/new/g' input.txt > output.txt

$ cat output.txt
new and new
```

複数のファイルにまたがって置換操作する場合に便利です。
正規表現が利用可能です。

## テキストファイルの差分 `diff`

```bash
$ printf 'abc\ndef\nghi\n' > a.txt
$ printf 'abc\nfed\nghi\n' > b.txt
$ cat a.txt
abc
def
ghi
$ cat b.txt
abc
fed
ghi

# a.txt と b.txt の差分を表示
$ diff a.txt b.txt
2c2
< def
---
> fed
```

2つのよく似たファイルの違いを知りたいときに便利です。

## 行数・単語数・バイト数の出力 `wc`

```bash
$ printf 'abc def\nghi\njkl\n' > file.txt
$ wc file.txt
      3       4      12 file.txt
# 3 行、4 単語、12 バイト

$ wc -l file.txt  # 行数のみ出力
      3 file.txt
$ wc -w file.txt  # 単語数のみ出力
      4 file.txt
```

## テキストの加工・集計 `awk`

まず、例として使う `data.txt` を作成します。

```bash
$ printf "apple 80 red\nbanana 120 yellow\napple 80 red\ncherry 150 red\n" > data.txt
```

中身は次のようになります。

```bash
$ cat data.txt
apple 80 red
banana 120 yellow
apple 80 red
cherry 150 red
```

```bash
# data.txt の各行について、1列目と3列目を表示
$ awk '{ print $1, $3 }' data.txt
apple red
banana yellow
apple red
cherry red

# data.txt の2列目が 100 より大きい行全体を表示
$ awk '$2 > 100 { print $0 }' data.txt
banana 120 yellow
cherry 150 red
```

テキストファイルを**行単位**で読み込み、フィールド（列、デフォルトはスペースやタブ区切り）ごとに分割して処理を行う強力なコマンドです。
特定のパターンにマッチした行に対して、指定したアクション（表示、計算など）を実行できます。簡単なデータ抽出、集計、レポート作成などによく利用されます。
`$1`, `$2` などでフィールドを参照し、`$0` で行全体を参照します。

## 並べ替えと重複集計 `sort` と `uniq`

`sort` コマンドは、テキストファイルの行を並べ替えるためのコマンドです。
`uniq` コマンドは、連続する重複行を削除するためのコマンドです。
どちらも、テキストファイルの内容を整理・集計する際に便利です。

```bash
# data.txt の内容を先頭の列で昇順に並べ替える
$ sort data.txt
apple 80 red
apple 80 red
banana 120 yellow
cherry 150 red

# 重複行を削除する (uniq コマンドは連続する重複行のみを削除するため、事前に sort が必要)
$ sort data.txt | uniq
apple 80 red
banana 120 yellow
cherry 150 red

# 重複行の出現回数をカウントする
$ sort data.txt | uniq -c
      2 apple 80 red
      1 banana 120 yellow
      1 cherry 150 red
```

## 文字コード・改行コードの判別・変換 `nkf`

```bash
# file.txt の文字コードと改行コードを判別して表示
$ nkf -g file.txt 
UTF-8 # または Shift_JIS など、文字コードの判別結果が出力される

# --guess オプションでは文字コードに加えて改行コードの判別結果も出力
$ nkf --guess file.txt
UTF-8 (CRLF)

$ nkf -w --overwrite file.txt      # UTF-8 に変換して上書き
$ nkf -Lu --overwrite file.txt     # 改行コードを LF に変換して上書き
```

文字コード・改行コードを判別するだけでなく、異なる文字コード・改行コードに変換することも可能です。

注意: `nkf` は Linux では標準でインストールされていない場合があります。
その場合は、 `sudo apt install nkf` などでインストールしてください (Ubuntu等の場合; ネットワーク接続が必要です)。

## **演習**: テキストファイルの操作

1. `vi` を使って `Hello World!` と記入されたファイル `hello_world.txt` を作りましょう。
2. `cat` または `less` を使って、`hello_world.txt` の中身を確認しましょう。
3. `sed` を使って、`hello_world.txt` から `Hello Linux!` と書かれたファイル `hello_linux.txt` を作りましょう。
4. `hello_world.txt` と `hello_linux.txt` を `diff` で比較しましょう。
5. `vi` を使って `hello_world.txt` を編集し、内容を `Hello Linux!` に変更しましょう。
6. `hello_world.txt` と `hello_linux.txt` を `diff` で比較して、両者が一致することを確認しましょう。

## コラム: 見えない文字とコーディングエージェント時代の注意

テキストファイルは人間が読める形式のファイルですが、画面に表示される見た目と、コンピュータが実際に処理している文字列が必ずしも一致するとは限りません。

例えば、次のような文字は見た目だけでは気づきにくいことがあります。

- ゼロ幅スペースなどの**不可視文字**
- 右から左に表示するための**双方向制御文字**
- 半角スペースと全角スペース
- ラテン文字の `A` と、ギリシャ文字・キリル文字などのよく似た文字
- 端末の表示を制御する**エスケープシーケンス**

このような文字が混入すると、見た目には同じファイル名・変数名・コマンドに見えるのに、実際には別の文字列として扱われることがあります。その結果、プログラムの動作が変わったり、CSV や設定ファイルの読み込みに失敗したり、コードレビューで問題を見落としたりする可能性があります。

近年は、コーディングエージェントや AI アシスタントにソースコード、設定ファイル、README、ログ、Webページの内容などを読ませる機会も増えています。この場合、人間には単なる文章やコメントに見える内容が、AI に対する指示として働いてしまう可能性があります。特に、AI がファイルを編集したり、コマンドを実行したり、外部ツールを呼び出したりできる場合には注意が必要です。

対策として、次のような点に注意しましょう。

- 出所の分からないコマンドを、そのまま端末に貼り付けて実行しない
- 出所の分からないファイルを、安易にコーディングエージェントへ読ませない
- AI が提案した変更は、必ず `git diff` などで確認してから採用する
- AI にコマンド実行を任せる場合でも、危険な操作や外部送信を許可しない
- ソースコードや設定ファイルでは、できるだけ ASCII 文字を使う
- ファイル名や変数名に、全角文字・空白・特殊記号をむやみに使わない
- エディタで不可視文字を表示する設定を有効にする
- 不審なファイルは `cat -v`, `od -c`, `sed -n l` などで中身を確認する

テキストファイルは「見えている文字」だけでなく、「実際に含まれている文字」と「それを誰が、どのように解釈するか」に注意することが重要です。
