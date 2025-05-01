# Linux入門(1): シェルとファイル

## LinuxとUNIX系OS

### UNIXとは

UNIX（ユニックス）は、1969年にAT&Tベル研究所でKenneth ThompsonとDennis Ritchieによって開発されたオペレーティングシステム（OS）です。

- **特徴**  
  - マルチユーザ／マルチタスクを標榜  
  - ファイルを中心に据えたシンプルな設計（"すべてはファイル"の哲学）  
  - テキスト処理やパイプによる小さなプログラムの組み合わせを重視  
- **歴史的意義**  
  - C言語で再実装されたことで移植性が飛躍的に向上  
  - 後の多くのOS設計に影響を与え、標準化（POSIX）につながった  

### Linuxとは

Linux（リナックス）は、1991年にLinus Torvaldsが発表した**カーネル**（OSの中核部分）です。

- **オープンソース**  
  - GPL（GNU General Public License）で公開
- **カーネルとディストリビューション**  
  - **カーネル**: ハードウェア管理やプロセス管理を担う  
  - **ディストリビューション**: カーネルに各種ユーティリティやパッケージ管理システム、GUIなどを組み合わせた配布形態  
- **代表的ディストリビューション**  
  - **Ubuntu**: 初心者向け、Debian系  
  - **Red Hat Enterprise Linux (RHEL)**: 商用サポートあり  
  - **その他**: Debian、Fedora、Rocky Linux、AlmaLinux、openSUSE など  

### 様々なUNIX系OSとPOSIX

- **UNIX系OSの広がり**  
  - **商用UNIX**: AIX（IBM）、HP‑UX（HPE）、Solaris（Oracle）など  
  - **BSD系**: FreeBSD、OpenBSD、NetBSD — オープンソース版UNIX  
  - **macOS**: Apple製OS。内部はBSD派生のDarwinをベースに独自GUIを搭載  
  - **Linux**: GPLベースで最も普及  
- **IEEE標準規格 POSIX**  
  - Portable Operating System Interfaceの略
  - UNIX系OS間の互換性を保つためのAPI／コマンド仕様  
- **本コースの位置づけ**  
  - UNIX系OSの主要な例として、Linuxの基礎知識および操作方法の習得を目指します

## シェルの操作

### 様々なシェル

- `sh`（Bourne Shell）: POSIX 標準に準拠した最低限の機能を持つシェル
- `bash`（Bourne Again Shell）: Bourne Shell の GNU プロジェクト版
- `dash` (Debian Almquist Shell): ほぼ純粋な POSIX 準拠、軽量高速
- `zsh`: 高度な補完・カスタマイズ機能  
- `csh/tcsh`: C風の構文。現在はあまり主流ではない  

このコースでは最も広く普及している `bash` を例に、多くのシェルで共通する機能を紹介します。

### シェルを終了する `exit` / `Ctrl-D`

- `exit`: シェルを終了 (`exit 1`のように終了ステータスを渡すことも可能)
- `Ctrl-D`: 標準入力の EOF シグナルを送信 (対話型シェルを終了)
- `reset`: シェルを再起動する

### 実行中のコマンドを中断する `Ctrl-C`

- 終了までに長い時間がかかるコマンドを中断する場合、`Ctrl-C`を押すと強制終了可能

### Tab によるコマンド補完

部分入力後に Tab を押すと、ファイル名／コマンド名を自動補完されます。
補完候補が複数ある場合は、再度 Tab を押すと一覧が表示されます。

```bash
$ cd Doc<Tab>   # Documents/ などに補完
```

### Ctrl-R による履歴閲覧

多くのシェルでは、インクリメンタルサーチで過去に利用したコマンドを呼び出すことができます。
TabとCtrl-Rを積極的に使い、できる限りタイピングの数を減らす習慣をつけましょう。

- `Ctrl-R` → 検索文字列入力 → 該当コマンドが表示  
- `Enter` で実行、`Ctrl-R` 再押下で次の候補  

```bash
(reverse-i-search)`ssh': ssh user@server.example.com
```

### カーソル移動のショートカット

| コマンド | 内容 |
| ---- | ---- |
| Ctrl + F | 1文字右へ移動 |
| Ctrl + B | 1文字左へ移動 |
| Ctrl + A | 行の先頭へ移動 |
| Ctrl + E | 行の最後へ移動 |
| Ctrl + P | 前の行へ移動 |
| Ctrl + N | 次の行へ移動 |
| Meta + F | 1単語右へ移動 |
| Meta + B | 1単語左へ移動 |

Metaキーは環境によって異なります。WindowsならAltキー、macOSならOptionキーが一般的です。
EscキーでMetaキーの代わりになる場合もあります。

### テキスト編集のショートカット

| コマンド | 内容 |
| ---- | ---- |
| Ctrl + H | カーソル左側の文字を削除 |
| Ctrl + D | カーソル位置の文字を削除 |
| Ctrl + W | カーソル位置の単語を削除 |
| Ctrl + U | カーソル位置から行頭まで削除 |
| Ctrl + K | カーソル位置から行末まで削除 |
| Ctrl + Y | 最後に削除した内容を挿入 |

### その他のショートカット

| コマンド | 内容 |
| ---- | ---- |
| Tab | コマンドの補間 |
| Ctrl + R | コマンドの履歴を呼び出し |
| Ctrl + C | 実行中のコマンドを停止 |
| Ctrl + Z | 実行中のコマンドを一時停止 |
| Ctrl + L | 画面の消去 (`clear`と同等) |
| Ctrl + D | 標準入力の EOF シグナルを送信 (対話型シェルを終了) |

### コマンドの呼び出し方

- コマンドの形式は `コマンド名 オプション 引数`
- 例: `ls -a ~/`
  - `ls`: コマンド名
  - `-a`: オプション(`--all`の別名)
  - `~/`: ホームディレクトリを示す引数
- 補足
  - オプションやファイル名は省略できる場合もある(コマンドによる)
  - ファイル名に空白や特殊文字が含まれる場合は引用符で囲む
    - 例: `ls "My Documents"`
  - オプションを複数指定する場合は並べる
    - 例: `ls -a -l -h` (`ls -alh` とまとめてもOK)
  - オプション自体が値をとる場合もある
    - 例: `grep -e pattern file.txt`

### シェル変数と環境変数

- **シェル変数**
  - `VAR=value` で定義
  - 定義したシェル内のみ有効
- **環境変数**
  - `export VAR` で定義
  - 子プロセスにも継承
  - 一覧表示: `env` または `printenv`

```bash
$ MYVAR=hello
$ echo $MYVAR
hello
$ bash -c 'echo $MYVAR'   # シェル変数は子プロセスで参照不能
                          # 何も出力されない
$ export MYVAR            # シェル変数を環境変数に
$ bash -c 'echo $MYVAR'   # 環境変数は子プロセスでも参照可能
hello
```

### 環境変数 PATH とコマンドの呼び出し

- `PATH` はコロン区切りのディレクトリリスト  
- シェルは左から順に実行ファイルを検索  
- 確認: `which <cmd>` / `which -a <cmd>` / `type <cmd>`  

```bash
$ echo $PATH
/usr/local/bin:/usr/bin:/bin:...

$ which python
/usr/bin/python

$ which -a python
/usr/bin/python
/usr/local/bin/python
```

### コマンドに別名をつける alias

- `alias name='command -options'` で短縮形を作成  
- `unalias name` で削除  

```bash
$ alias ll='ls -lah'
$ type ll
ll is aliased to `ls -lah`

$ ll
drwxr-xr-x 5 user user 4.0K Apr  7 10:00 .
```

### シェルの設定 `~/.bashrc`、`~/.bash_profile`

- `~/.bash_profile`（または `~/.profile`）  
  - **ログインシェル** 起動時に読み込まれる  
  - リモート SSH ログインやコンソールログイン時に適用  
- `~/.bashrc`  
  - **インタラクティブ非ログインシェル** 起動時に読み込まれる  
  - ターミナルエミュレータ（例: GNOME Terminal）や `bash` コマンド実行時に適用  

共通設定を両方で使いたい場合は、`~/.bash_profile` から `~/.bashrc` を呼び出すようにします。

```bash
# ~/.bash_profile
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
```  

`~/.bashrc` に書く典型例。

```bash
# プロンプト設定
export PS1="\u@\h:\w\$ "

# エイリアス
alias ll='ls -lah'
alias gs='git status'

# 環境変数追加
export PATH="$HOME/bin:$PATH"

# エディタ設定
export EDITOR=vim
```  

- **反映方法**  
  - 編集後、既存ターミナルに反映するには `source ~/.bashrc` を実行
  - 新しいターミナルを開けば自動適用
- **注意点**  
  - シェルごとに設定ファイルの名前・読み込み順序が異なる（例: zsh は `~/.zshrc`）  
  - 不要な設定や無限ループを作らないように、条件分岐や存在チェックを行うこと

## ヘルプとトラブルシューティング

### コマンドの使い方がわからない時に `man`, `<command> --help`

- `man <command>`: システムにインストールされているマニュアルページを表示します。  
- キーバインド
  - `q`: 終了
  - `h`: ヘルプ
- `SYNOPSIS`行の読み方
  - 角括弧 `[ ]` は「省略可」
  - 三点リーダ `...` は「複数可」

```bash
man ls
```

- `<command> --help`: 簡易的な使い方やオプション一覧を表示します。  
- `Usage`行の読み方
  - 角括弧 `[ ]` は「省略可」  
  - `...` は「複数引数 OK」  

```bash
ls --help
```

### **演習**: コマンドの使い方を調べてみよう

1. コマンド `ls` は何を目的とするコマンド？
2. コマンド `ls` でサイズを人間に読める単位 (human readable) で表示するには？

### エラーを読むくせをつける

- **エラーメッセージをまず自分で読む**  
  - 何が問題か（ファイルがない、権限がない、引数が不正 など）を把握  
- **検索エンジンやAIに質問**  
  - エラーメッセージ全文をコピーして検索  
  - セキュリティ情報（パスワード、鍵ファイルのパスなど）を含めてはいけません
- **よく見るエラーは記憶しておく**  
  - 慣れてくると一目で原因が分かるようになります

### **演習**: エラーを出してみよう

**存在しないファイルへアクセス**

```bash
$ ls no_such_file.txt
ls: cannot access 'no_such_file.txt': No such file or directory
```

**存在しないコマンドを実行**

```bash
$ not_a_real_command
bash: not_a_real_command: command not found
```

**引数の不足するコマンド実行**

```bash
$ rm
rm: missing operand
```

**存在しないディレクトリへアクセス**

```bash
$ cd /no/such/dir
bash: cd: /no/such/dir: No such file or directory
```

**権限のないファイル操作**

```bash
$ touch test.txt
$ chmod 000 test.txt
$ cat test.txt
Permission denied
$ echo hoge >> test.txt
Permission denied
```

## ファイル・ディレクトリの操作

### Linux では「すべてはファイル」

Linuxでは、デバイスやプロセス情報、設定インタフェースなど、あらゆるリソースが「ファイル」として表現されます

- 通常のファイルやディレクトリ
- `/dev/null` や `/dev/sda1`（デバイス）
- `/proc/cpuinfo`（CPU情報）
- ソケットファイルやパイプ

そのため、ファイル操作はLinuxにおいて本質的な役割を果たします。とは言え、直接ファイルを触ると煩雑でヒューマンエラーの危険があるため、実際にデバイスを扱う場合は専用のコマンドを使うことが大半です。

### ファイルの一覧を取得 `ls`

```bash
ls             # 現在のディレクトリの一覧
ls -l          # 詳細表示
ls -a          # 隠しファイル（.で始まる）を含めて表示
ls -lh         # サイズを人間に読みやすい単位で表示
```

### ワイルドカード `*`、`?`、`[ ]`、`[! ]`

- `*` : 任意の長さの文字列にマッチ
- `?` : 任意の1文字にマッチ
- `[a-c]` : aからcまでの任意の1文字にマッチ
- `[3-9]` : 3から9までの任意の1文字にマッチ
- `[^a-c]` : aからcまでの文字以外の任意の1文字にマッチ
- **注意**: 正規表現とは異なるパターンマッチのルールで、**グロブ**（glob）とも呼ばれます

### 今どこにいるの？ `pwd`

```bash
pwd  # カレントディレクトリ（作業中の場所）を表示
```

### パスの読み方

- パス: ファイルやディレクトリの場所を示す文字列
- 絶対パス: ルート(`/`)からの完全なパス `/home/user/project`
- 相対パス: 現在地から見た相対的なパス
  - 例: 現在地が `/home/user/project` の場合、現在地から見た `/home/user/other` の相対パスは `../other`
- 主な記号と意味
  - `.`: 現在のディレクトリ
  - `..`: 親ディレクトリ (一つ上のディレクトリ)
  - `~`: ユーザーのホームディレクトリ (環境変数 `HOME` に展開される)

### ディレクトリの移動 `cd`

```bash
$ cd /path/to/dir
$ cd ..       # 親ディレクトリへ
$ cd -        # 直前のディレクトリに戻る
$ cd          # 何もつけなければホームディレクトリに戻る
```

### 標準出力・標準入力・標準エラー出力

UNIXでは、端末やファイルとのやりとりもすべてファイルを介して行われます。

- 標準出力（stdout）: ファイル記述子 1
- 標準エラー出力（stderr）: ファイル記述子 2
- 標準入力（stdin）: ファイル記述子 0

```bash
$ echo "Hello, world!"  # 標準出力に Hello, world!
$ ls no_such_file.txt   # 標準エラー出力に No such file or directory
```

### パイプとリダイレクト

- パイプ: `|` を使って、出力を次のコマンドの入力へ渡す
- リダイレクト: `>`（上書き）、`>>`（追記）、`2>`（標準エラー）など

```bash
$ ls
$ ls -l | grep a
$ ls non_such_file.txt 2> error.log
```

### 空ファイルの作成 `touch`

本来はファイルの最終アクセス日時を更新するためのコマンドですが、空ファイルの作成に良く使われます。

```bash
$ touch newfile.txt
```

### ディレクトリの作成・削除 `mkdir` `rmdir`

```bash
$ mkdir newdir
$ mkdir -p parent/child/grandchild  # 再帰的にディレクトリを作成
$ rmdir newdir                      # 空でないと失敗する
```

### ファイル・ディレクトリの削除 `rm`

```bash
$ rm file.txt
$ rm -r directory/     # ディレクトリを再帰的に削除
```

### ファイル・ディレクトリのコピー・移動 `cp`、`mv`

```bash
$ cp source.txt dest.txt
$ cp -r src_dir/ dest_dir/   # ディレクトリを再帰的にコピー

$ mv oldname.txt newname.txt
$ mv file.txt ~/             # 移動
```

### テキストファイルとバイナリファイル

- ファイルとは、本質的には**バイト列（データの羅列）**です。
- 文字もデータの一種であり、文字コード（例：UTF-8, ASCII）に従って表現されます。
- **テキストファイル**とは、**文字データのみ**で構成されており、**人間が直接読める形式**のファイルを指します（例：`.txt`, `.csv`, `.py`）。
- **バイナリファイル**とは、**文字以外のデータ（画像・音声・実行ファイルなど）を含む**ファイルの総称であり、テキストとして開くと意味不明な記号が並んでいます。

### 文字コードと特殊文字に関する注意点

| 落とし穴 | 具体例 | 対策 |
|-----------|--------|------|
| **全角／半角の混在** | `ＡＢＣ.txt` と `ABC.txt` は別ファイル扱い | ファイル名・入力データは **半角（ASCII）** を原則にする |
| **全角スペース・半角スペース** | `ファイル 名.txt`（全角空白）、`file name.txt`（半角空白） | どちらも見分けにくいので **空白を避ける or "引用符" で囲む** |
| **タブ文字** | 行頭インデントがスペースかタブか不明 | エディタで「タブ可視化」設定＋ **tab → 4 space 変換** ルールを統一 |
| **不可視制御文字** | 0x1B (ESC) などが混入し、CSV 解析時にエラー | `cat -v` / `od -c` で点検、不要なら `tr -d` で除去 |
| **改行コード差** | Unix: LF (`\n`)、Windows: CRLF (`\r\n`) | Git の `core.autocrlf` を設定、`dos2unix`/`unix2dos` で変換 |
| **Unicode 正規化の揺れ** | `é` (U+00E9) vs `e`+`́` (U+0065 U+0301) | 入出力を **UTF-8 NFC** に統一、`iconv`・`uconv` で整形 |

### ファイルの種類 `file`

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

### ファイルの検索 `find`

```bash
# 現在のディレクトリ以下でファイル名が *.txt にマッチするファイルを検索
$ find . -name "*.txt"

# /path 以下のファイル(ディレクトリは除く)のうちサイズが10MB以上のものを検索
$ find /path -type f -size +10M
```

### ファイル・ディレクトリの容量 `ls -lh`、`du -hs`

```bash
$ ls -lh           # サイズ表示
$ du -hs folder/   # ディレクトリの合計サイズ
```

### アクセスの権限の確認 `ls -l`

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

### アクセスの権限の変更 `chmod`

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

### シンボリックリンク `ln -s`

- いわゆるショートカットの作成

```bash
$ ln -s target.txt link.txt
```

### ファイルの圧縮・アーカイブ `zip`、`unzip`、`tar`

```bash
$ zip archive.zip file1 file2
$ unzip archive.zip

$ tar -cvf archive.tar folder/  # アーカイブの作成
$ tar -xvf archive.tar          # アーカイブの展開
```

### **演習**: 色々なファイル操作

- 隠しファイルを含むファイル一覧を表示しましょうい
- 空のファイルを3つ作成し、まとめて削除しましょう
- `~/dir1/hello.txt` を作り、`~/dir2/hello.txt` へシンボリックリンクを貼りましょう

## テキストファイルの操作

### テキストファイルの編集 `vi`

```bash
$ vi filename.txt
```

- Linuxなら大抵インストールされているため使えると便利です
  - 実際の利用方法は長くなるので各自で調べてください
- 最低限、終了方法だけは覚えておきましょう (`<Esc>ZZ` または `<Esc>:q!`)

### テキストファイルの閲覧 `cat, less, head, tail`

```bash
cat file.txt
less file.txt
head -n 10 file.txt
tail -f file.txt
```

- `less` は長いファイルをページ送りで見る際に便利
- `tail -f` は末尾に更新が続くログファイルなどを読み続ける際に便利

### テキストファイルの検索 `grep`

```bash
grep "keyword" file.txt
grep -r "pattern" ./      # ディレクトリ以下を再帰的に検索
```

正規表現が利用可能です。

### テキストファイルの置換 `sed`

```bash
# input.txtのoldをnewに置換してoutput.txtに書き込み
$ sed 's/old/new/g' input.txt > output.txt
```

複数のファイルにまたがって置換操作する場合に便利です。
正規表現が利用可能です。

### テキストファイルの差分 `diff`

```bash
$ echo 'abc\ndef\nghi' > a.txt
$ echo 'abc\nfed\nghi' > b.txt
$ diff a.txt b.txt
2c2
< def
---
> fed
```

### テキストの加工・集計 `awk`

```bash
# data.txt の各行について、1列目と3列目を表示
$ awk '{ print $1, $3 }' data.txt 

# data.txt の2列目が 100 より大きい行全体を表示
$ awk '$2 > 100 { print $0 }' data.txt
```

テキストファイルを**行単位**で読み込み、フィールド（列、デフォルトはスペースやタブ区切り）ごとに分割して処理を行う強力なコマンドです。
特定のパターンにマッチした行に対して、指定したアクション（表示、計算など）を実行できます。簡単なデータ抽出、集計、レポート作成などによく利用されます。
`$1`, `$2` などでフィールドを参照し、`$0` で行全体を参照します。

### 書式付き文字列の出力 `printf`

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

### 文字コード・改行コードの判別・変換 `nkf`

```bash
# file.txt の文字コードと改行コードを判別して表示
$ nkf -g file.txt 
UTF-8 # または Shift_JIS など、文字コードの判別結果が出力される

# --guess オプションでは文字コードに加えて改行コードの判別結果も出力
$ nkf --guess file.txt
UTF-8 (CRLF)
```

文字コード・改行コードを判別するだけでなく、異なる文字コード・改行コードに変換することも可能です。

### **演習**: テキストファイルの操作

1. `vi` を使って `Hello World!` と記入されたファイル `hello_world.txt` を作りましょう。
2. `sed` を使って `hello.txt` から `Hello Linux!` と書かれたファイル `hello_linux.txt`を作りましょう。
3. `hello_world.txt` と `hello_linux.txt` を `diff` で比較しましょう。
4. `vi` を使って `hello_word.txt` を編集し、内容を `Hello Linux!` に変更しましょう。
5. `hello_world.txt` と `hello_linux.txt` を `diff` で比較して両者が一致することを確認しましょう。
