# シェルスクリプト 〜再現可能なシェル操作〜

一連のコマンドを `.sh` ファイルにまとめることで、作業の再現性確保と自動化が実現できます。

## シェルスクリプトの例

基本的には、インタラクティブシェルで使うようなコマンドを並べるとシェルスクリプトになります。

以下は簡単なシェルスクリプトの例です。
エディタで以下の内容を `hello.sh` として保存しましょう。

```bash
#!/usr/bin/env bash
echo "Hello, Shell Script!"
echo "This is a simple shell script!"
```

実行方法は以下のとおりです。

```bash
$ bash hello.sh
Hello, Shell Script!
This is a simple shell script!
```

`echo` コマンドが2回実行され、2行の出力が得られました。

このように、シェルスクリプトは複数のコマンドをまとめて実行することが出来ます。
同じような作業を何度もコマンドで打っていると感じる場合、シェルスクリプトにまとめることが出来るか考えてみましょう。

## シェルスクリプトの実行方法

毎度 `bash` を打つのが手間なら、以下のように実行権限を付与すると良いでしょう。

```bash
$ chmod +x hello.sh
$ ./hello.sh
Hello, Shell Script!
This is a simple shell script!
```

ただし、このような実行方法では、ファイル先頭に `#!/usr/bin/env bash` の行 (**シバン**; shebang) が必要となります。
この行の意味は、現在の `PATH` から `bash` コマンドを検索し、その `bash` コマンドを通してこのスクリプトを実行することを、OSに伝えるための記述です。`bash` のパスが `/bin/bash` であることが分かっている場合は、以下のように書くことも出来ます。

```bash
#!/bin/bash
```

Linuxでは、ファイルの拡張子は実行方法を決めません。シバンを記述して実行権限を付与すれば、拡張子 `.sh` を付けずに自作コマンドのような名前で実行できます。
例えば、`hello` という名前のファイルでも、実行権限が付与されていれば、以下のように実行できます。

```bash
$ chmod +x hello
$ ./hello
Hello, Shell Script!
This is a simple shell script!
```

このシェルスクリプトが存在するディレクトリを `PATH` に追加してみましょう。
通常のコマンドのように `hello` とだけ打って実行できるようになります。

```bash
$ mkdir -p ~/bin
$ mv hello ~/bin/
$ export PATH="$PATH:$HOME/bin"
$ hello
Hello, Shell Script!
This is a simple shell script!
```

シェルスクリプトを自作コマンドとして作る場合は、`PATH` に自作コマンドが存在するディレクトリを追加しておくと便利です。

## 変数と配列

### シェル変数

シェルスクリプトの変数は、通常のインタラクティブなシェルで使うシェル変数と同じです。

```bash
#!/usr/bin/env bash
# 変数の定義
name="Shell Script"
# 変数の参照
echo "Hello, $name!"
```

インタラクティブなシェルと同様、`=` の前後にスペースを入れるとエラーになります。

```bash
name = "Shell Script"  # NG
```

### 環境変数

環境変数をシェルスクリプト内で参照することも可能です。

```bash
#!/usr/bin/env bash
# 環境変数の参照
echo "Current user: $USER"
echo "Current directory: $PWD"
```

### 配列

配列は以下のように定義・参照することができます。

```bash
#!/usr/bin/env bash
# 配列の定義
fruits=("apple" "banana" "cherry")
# 配列の参照
echo "First fruit: ${fruits[0]}"   # First fruit: apple
echo "Second fruit: ${fruits[1]}"  # Second fruit: banana
echo "All fruits: ${fruits[@]}"    # All fruits: apple banana cherry
```

一度定義した配列に要素を追加することも可能です。

```bash
#!/usr/bin/env bash
# 配列の定義
fruits=("apple" "banana")
# 配列に要素を追加
fruits+=("cherry")
# 配列の参照
echo "All fruits: ${fruits[@]}"    # All fruits: apple banana cherry
```

### コマンドの出力

コマンドの標準出力を変数に格納することも可能です。

```bash
#!/usr/bin/env bash
# コマンドの標準出力を変数に格納
current_date=$(date)
echo "Current date and time: $current_date"
```

### 変数の削除

変数を削除するには、`unset` コマンドを使用します。

```bash
#!/usr/bin/env bash
# 変数の定義
name="Shell Script"
echo "Before unset: $name"
# 変数の削除
unset name
echo "After unset: $name"  # 変数は存在しないため、空の出力となる
```

### スクリプト名とコマンドライン引数

シェルには、特別な意味を持つ変数 (特殊変数) がいくつかあります。
以下は、シェルスクリプト内でよく使われる特殊変数の例です。

- `$0`: スクリプトの名前
- `$1`, `$2`, ...: コマンドライン引数
- `$#`: コマンドライン引数の数
- `$@`: すべてのコマンドライン引数

これにより、引数によってシェルスクリプトの挙動を変えることができます。
以下は、コマンドライン引数を受け取り、そのまま標準出力に表示するシェルスクリプトの例です。

```bash
#!/usr/bin/env bash
echo "$@"
```

これを `myecho.sh` という名前で保存した場合、以下のように実行できます。

```bash
$ ./myecho.sh Hello World!
Hello World!
$ bash myecho.sh Hello World!
Hello World!
```

## 制御文: 条件分岐

### 整数同士の比較

以下は整数同士の比較を行う `if` 文の例です。
`]` の後のセミコロン `;` を忘れないようにしてください。
`;` をつける代わりに改行しても構いません。

```bash
# 変数の定義
num=10

# 整数の比較
if [ $num -gt 5 ]; then
  echo "$num is greater than 5"
else
  echo "$num is not greater than 5"
fi
```

ここで、`-gt` は「greater than（より大きい）」を意味する整数としての比較演算子です。
以下のような比較演算子があります。

- `-gt`: greater than（より大きい）
- `-lt`: less than（より小さい）
- `-eq`: equal（等しい）
- `-ne`: not equal（等しくない）
- `-ge`: greater than or equal（以上）
- `-le`: less than or equal（以下）

### 文字列同士の比較・判定

以下に文字列同士の比較演算子を示します。

- `=`: 等しい
- `!=`: 等しくない
- `-z`: 文字列が空である
- `-n`: 文字列が空でない

```bash
str1="hello"
str2="world"
if [ "$str1" = "$str2" ]; then
  echo "Strings are equal"
else
  echo "Strings are not equal"
fi
```

### ファイルの存在

ファイルやディレクトリの存在の判定には以下のような演算子を使用します。

- `-e`: ファイル又はディレクトリが存在する
- `-f`: 通常のファイルが存在する
- `-d`: ディレクトリが存在する

```bash
# ファイルの存在確認
if [ -e "example.txt" ]; then
  echo "example.txt exists"
else
  echo "example.txt does not exist"
fi
```

### 論理演算子

複数の条件を組み合わせる場合は、論理演算子を使用します。

```bash
num=10
if [ $num -gt 5 ] && [ $num -lt 15 ]; then
  echo "$num is between 5 and 15"
else
  echo "$num is not between 5 and 15"
fi
```

## 制御文: ループ

### `for` ループ

以下は、1から5までの数値を出力するシェルスクリプトです。

```bash
#!/usr/bin/env bash
for i in 1 2 3 4 5; do
  echo "Number: $i"
done
```

出力:

```log
Number: 1
Number: 2
Number: 3
Number: 4
Number: 5
```

### `seq` コマンド

コマンド `seq` を使うと、連続する数値を簡単に生成できます。

```bash
for i in $(seq 1 5); do
  echo "Number: $i"
done
```

出力:

```log
Number: 1
Number: 2
Number: 3
Number: 4
Number: 5
```

`-f` オプションを使うと、出力フォーマットを指定できます。

```bash
for i in $(seq -f "%04g" 1 5); do
  echo "Number: $i"
done
```

出力:

```log
Number: 0001
Number: 0002
Number: 0003
Number: 0004
Number: 0005
```

### 配列の参照

配列の要素をループで参照することも可能です。

```bash
fruits=("apple" "banana" "cherry")
for fruit in "${fruits[@]}"; do
  echo "Fruit: $fruit"
done
```

出力:

```log
Fruit: apple
Fruit: banana
Fruit: cherry
```

### ループの中断

`break` コマンドを使用して、ループを中断できます。

```bash
for i in $(seq 1 10); do
  if [ $i -eq 5 ]; then
    echo "Breaking the loop at $i"
    break
  fi
  echo "Number: $i"
done
```

出力:

```log
Number: 1
Number: 2
Number: 3
Number: 4
Breaking the loop at 5
```

### ループのスキップ

`continue` コマンドを使用して、ループの現在の反復をスキップし、次の反復に進むことができます。

```bash
for i in $(seq 1 10); do
  if [ $i -lt 6 ]; then
    echo "Skipping number $i < 6"
    continue
  fi
  echo "Number: $i"
done
```

出力:

```log
Skipping number 1 < 6
Skipping number 2 < 6
Skipping number 3 < 6
Skipping number 4 < 6
Skipping number 5 < 6
Number: 6
Number: 7
Number: 8
Number: 9
Number: 10
```

## 終了ステータス

各コマンドは、実行終了時に正常に終了したかどうかのステータスをOSに返します。正常終了した場合は `0`、異常終了した場合は `0` 以外の値を返します。
直前のコマンドの終了ステータスは、特殊変数 `$?` で参照することができます。

```bash
#!/usr/bin/env bash
# コマンドの実行
ls /nonexistent_directory
# 終了ステータスの確認
if [ $? -ne 0 ]; then
  echo "The command failed"
else
  echo "The command succeeded"
fi
```

シェルスクリプトを任意の終了ステータスで終了させるには、`exit` コマンドを使用します。

```bash
#!/usr/bin/env bash
exit 1  # ステータス1で異常終了
```

このファイルを `exit_with_error.sh` として保存し、実行すると、終了ステータスが `1` となります。

```bash
$ bash exit_with_error.sh
$ echo $?
1
```

ネットワーク接続や特定の条件を満たすファイルの検索など、失敗する可能性がある処理を行う場合は、終了ステータスを確認して適切な処理を行うと柔軟性が増します。

## カラム: ワンライナー 〜複数のコマンドを一行で〜

複数のコマンドを1行にまとめて書くことで、簡単な処理をスクリプト化せずに実行できます。
長いワンライナーは可読性が低下するため、なるべく短くまとめることを意識しましょう。

```bash
$ cmd1 ; cmd2 ; cmd3    # 各コマンドを順に実行（失敗しても続行）
$ cmd1 && cmd2 && cmd3  # 前のコマンドが成功したら次を実行 (失敗した時点で停止)
$ cmd1 || cmd2          # 前のコマンドが失敗したら次を実行
```

特に、`||`は失敗する可能性があるコマンドのエラー処理を短く書くのに便利です。
例えば、`exit 1` と組み合わせて、コマンドが失敗した場合にスクリプトを終了させることもできます。

```bash
#!/usr/bin/env bash
# ホームディレクトリにディレクトリ `dir_name` があれば移動し、なければ異常終了する
cd ~/dir_name || exit 1
```

## シェルスクリプトの例

いくつかよく使うシェルスクリプトの例を紹介します。

### 例: 連番ファイルを生成するスクリプト

ゼロ埋め4桁の連番ファイル `file_0001.txt file_0002.txt ... file_0010.txt` を生成するスクリプトの例です。

```bash
#!/usr/bin/env bash
for i in $(seq -f "%04g" 1 10); do
  touch "file_${i}.txt"
done
```

### 例: ディレクトリの配列を作成し、各ディレクトリで同じ動作を行うスクリプト

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
  mkdir -p "$dir"
  cd "$dir" || exit 1  # ディレクトリに移動できなければスクリプトを終了
  ls -l  # ここに実行したい処理を記述
  cd - || exit 1  # 元のディレクトリに戻れなければスクリプトを終了
done
```

### 例: ネットワークごしに複数コマンドを実行するスクリプト

```bash
#!/usr/bin/env bash
ssh user@remote <<EOF
pwd
ls -l
date
EOF
```

`ssh` コマンドについては、計算機ネットワークのセクションで説明します。

## 事故を防ぐためのポイント

シェルスクリプトは簡単に書けますが、C言語やPythonのようなプログラミング言語と比べると、型の扱いが限定的でエラー処理も見逃しやすいため事故が発生しやすく、利用には注意が必要です。

### 複雑なシェルスクリプトを書かない

最も有効な事故防止策は、なるべく複雑なシェルスクリプトを書かないことです。
意図せぬバグを埋め込みやすいのがシェルスクリプトの弱点です。

**シェルスクリプトが最も有効に働くのは、短い単純作業の自動化**です。
シェルスクリプトを書いていて大変になったと感じたら、Pythonなどに置き換えることを検討しましょう。

### 変数の値は文字列

シェルスクリプトでは、変数の値は基本的に文字列として扱われます。数値として扱いたい場合は、整数同士の比較演算子などを使用する必要があります。

ファイル名やディレクトリ名に空白が含まれる場合は、変数を参照する際にダブルクオート `""` を付けましょう。例えば、以下は空白を含む文字列を変数に格納した場合の例です。

```bash
$ message="Hello World"
$ printf '<%s>\n' "$message"  # 1つの引数として渡される
<Hello World>
$ printf '<%s>\n' $message    # 空白で分割され、2つの引数として渡される
<Hello>
<World>
```

引用符を付けない場合、空白による分割だけでなく、`*` や `?` などのワイルドカードも展開されます。

```bash
$ touch apple.txt banana.txt
$ pattern="*.txt"
$ printf '<%s>\n' $pattern
<apple.txt>
<banana.txt>
$ printf '<%s>\n' "$pattern"
<*.txt>
```

配列では、それぞれの要素が空白やワイルドカードを含むことがあります。

```bash
$ arr=("Hello World" "Goodbye World")
```

配列の全要素を、それぞれ独立した引数として展開するには、次のように書きます。

```bash
$ printf '<%s>\n' "${arr[@]}"
<Hello World>
<Goodbye World>
```

引用符を付けずに展開すると、各要素がさらに空白で分割されます。

```bash
$ printf '<%s>\n' ${arr[@]}
<Hello>
<World>
<Goodbye>
<World>
```

したがって、空白などを含む可能性のある文字列や配列の各要素をそのまま扱いたい場合は、ダブルクオートを使用します。特に、配列の全要素を展開する場合は `"${arr[@]}"` と書きます。

### シェル変数はカギ括弧 `{}` で囲む

シェル変数を参照する際に、変数名の後に文字列が続く場合は、変数名をカギ括弧 `{}` で囲む必要があります。

```bash
$ name="Alice"
$ echo "Hello, $name!"
Hello, Alice!
$ echo "Hello, $name123!"
Hello, !
$ echo "Hello, ${name}123!"
Hello, Alice123!
```

`!` や `.` は変数名には使えないので最初の例では `$name!` と書いても問題ありませんが、`123` は変数名に使える文字なので、2つ目の例では `$name123` という変数を参照しようとしてしまい、意図しない結果になります。3つ目の例のように `${name}` と書くことで、変数名を明示的に区切ることができます。

### 実行中のシェルスクリプトを編集しない

シェルスクリプトは、ファイルからコマンドを読み込みながら順番に実行します。実行中のシェルスクリプトを書き換えると、書き換え前と書き換え後の内容が混在して実行される可能性があります。

どの時点までファイルの内容が読み込まれているかは、シェルの実装やファイルの大きさなどにも依存するため、編集結果が必ず実行中の処理に反映されるとは限りません。挙動を予測できないこと自体が危険です。

以下のスクリプトを `test.sh` として保存します。

```bash
#!/usr/bin/env bash

echo "処理1を開始します"
sleep 10

echo "処理2を実行します"
sleep 10

echo "処理3を実行します"
```

別の端末から実行します。

```bash
bash test.sh
```

最初の `sleep 10` の間に、例えば後半を次のように編集して保存します。

```bash
echo "処理1を開始します"
sleep 10

echo "書き換え後の処理2を実行します"
sleep 10

echo "書き換え後の処理3を実行します"
```

実行中に変数の設定、条件分岐、ループ、削除対象などを書き換えると、意図しないファイルが処理対象になる可能性があります。実行中のスクリプトを修正したい場合は、一旦実行中の処理を停止し、改めて最初からスクリプトを実行するようにしましょう。

### `set -euo pipefail` を設定する

シェルスクリプトの冒頭では、予期しないエラーを見逃しにくくするため、次の設定を付けることを推奨します。

```bash
#!/usr/bin/env bash
set -euo pipefail
```

それぞれのオプションには、次の意味があります。

- `-e`: コマンドがエラー終了した場合、スクリプトを停止する
- `-u`: 未定義の変数を参照した場合、スクリプトを停止する
- `-o pipefail`: パイプライン途中のコマンドが失敗した場合も、パイプライン全体をエラーとする

すべてのバグを自動的に防ぐものではありませんが、変数名の間違いやコマンドの失敗を早い段階で検出するための基本的な設定です。

例えば、`-e` の例を見てみましょう。
通常、あるコマンドが失敗しても、シェルスクリプトは次の処理を続けます。

```bash
#!/usr/bin/env bash

cp input.dat backup/input.dat
rm input.dat
```

この例では、`cp` に失敗してバックアップが作成されなかった場合でも、次の `rm` が実行される可能性があります。

```bash
#!/usr/bin/env bash
set -e

cp input.dat backup/input.dat
rm input.dat
```

`set -e` を指定すると、`cp` がエラー終了した時点でスクリプトが停止するため、バックアップに失敗したまま元ファイルを削除する事故を防ぎやすくなります。

## **演習**: 挨拶

- コマンドライン引数として名前を受け取り、挨拶を表示するスクリプトを作りなさい。
- ただし、引数が指定されなかった場合は、"Hello, World!" と表示すること。

```bash
# 実行例
$ ./greet.sh Alice
Hello, Alice!
$ ./greet.sh
Hello, World!
```

## **演習**: ファイル・ディレクトリ構造の作成

以下のようなファイル・ディレクトリ構造を作成するシェルスクリプトを作りなさい。

```shell
project/
├── data/
│   ├── input0001.dat
│   ├── input0002.dat
│   ├── ...
│   ├── input0098.dat
│   └── input0099.dat
├── scripts/
│   └── process.sh
└── results/
    └── output.dat
```
