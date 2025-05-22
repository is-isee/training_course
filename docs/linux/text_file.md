# テキストファイルの操作

## テキストファイルとバイナリファイル

- ファイルとは、本質的には**バイト列（データの羅列）**です。
- 文字もデータの一種であり、文字コード（例：UTF-8, ASCII）に従って表現されます。
- **テキストファイル**とは、**文字データのみ**で構成されており、**人間が直接読める形式**のファイルを指します（例：`.txt`, `.csv`, `.py`）。
- **バイナリファイル**とは、**文字以外のデータ（画像・音声・実行ファイルなど）を含む**ファイルの総称であり、テキストとして開くと意味不明な記号が並んでいます。

## 文字コードと特殊文字に関する注意点

| 落とし穴 | 具体例 | 対策 |
|-----------|--------|------|
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

- Linuxなら大抵インストールされているため使えると便利です
  - 実際の利用方法は長くなるので各自で調べてください
- 最低限、終了方法だけは覚えておきましょう (`<Esc>ZZ` または `<Esc>:q!`)

## テキストファイルの閲覧 `cat, less, head, tail`

```bash
cat file.txt
less file.txt
head -n 10 file.txt
tail -f file.txt
```

- `less` は長いファイルをページ送りで見る際に便利
- `tail -f` は末尾に更新が続くログファイルなどを読み続ける際に便利

## テキストファイルの検索 `grep`

```bash
grep "keyword" file.txt
grep -r "pattern" ./      # ディレクトリ以下を再帰的に検索
```

正規表現が利用可能です。

## テキストファイルの置換 `sed`

```bash
# input.txtのoldをnewに置換してoutput.txtに書き込み
$ sed 's/old/new/g' input.txt > output.txt
```

複数のファイルにまたがって置換操作する場合に便利です。
正規表現が利用可能です。

## テキストファイルの差分 `diff`

```bash
$ echo 'abc\ndef\nghi' > a.txt
$ echo 'abc\nfed\nghi' > b.txt
$ diff a.txt b.txt
2c2
< def
---
> fed
```

## テキストの加工・集計 `awk`

```bash
# data.txt の各行について、1列目と3列目を表示
$ awk '{ print $1, $3 }' data.txt 

# data.txt の2列目が 100 より大きい行全体を表示
$ awk '$2 > 100 { print $0 }' data.txt
```

テキストファイルを**行単位**で読み込み、フィールド（列、デフォルトはスペースやタブ区切り）ごとに分割して処理を行う強力なコマンドです。
特定のパターンにマッチした行に対して、指定したアクション（表示、計算など）を実行できます。簡単なデータ抽出、集計、レポート作成などによく利用されます。
`$1`, `$2` などでフィールドを参照し、`$0` で行全体を参照します。

## 書式付き文字列の出力 `printf`

```bash
$ printf "Hello World\n"
Hello World

$ USER="Bob"
$ ID=123
$ printf "User: %s, ID: %d\n" "$USER" $ID
User: Bob, ID: 123

$ VALUE=42
$ printf "File Name: z%04d.txt\n" $VALUE
File Name: z0042.txt
```

## 文字コード・改行コードの判別・変換 `nkf`

```bash
# file.txt の文字コードと改行コードを判別して表示
$ nkf -g file.txt 
UTF-8 # または Shift_JIS など、文字コードの判別結果が出力される

# --guess オプションでは文字コードに加えて改行コードの判別結果も出力
$ nkf --guess file.txt
UTF-8 (CRLF)
```

文字コード・改行コードを判別するだけでなく、異なる文字コード・改行コードに変換することも可能です。

## **演習**: テキストファイルの操作

1. `vi` を使って `Hello World!` と記入されたファイル `hello_world.txt` を作りましょう。
2. `sed` を使って `hello.txt` から `Hello Linux!` と書かれたファイル `hello_linux.txt`を作りましょう。
3. `hello_world.txt` と `hello_linux.txt` を `diff` で比較しましょう。
4. `vi` を使って `hello_word.txt` を編集し、内容を `Hello Linux!` に変更しましょう。
5. `hello_world.txt` と `hello_linux.txt` を `diff` で比較して両者が一致することを確認しましょう。
