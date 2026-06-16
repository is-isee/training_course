# 第1回: Linux入門、GitHubを利用した課題提出

## Linux入門

以下の内容を学習してください。

- [LinuxとUNIX系OS](../linux/linux_and_unix.md)
- [シェルとターミナル](../linux/shell.md)
- [ヘルプとマニュアル](../linux/help_and_man.md)

## GitHubを利用した課題提出

- 課題はMarkdown形式のテキストファイル (`ファイル名.md`) で提出してください。
- 必要に応じて画像ファイルもGitHubリポジトリに含めて提出して構いません。

### Markdown記法

基本的なMarkdown記法を以下に示します。

````markdown
# 見出し

- `#` から始まる行は最も大きい見出し
  - 1ファイルにつき1つが基本
- `##` から始まる行は2番目に大きい見出し
  - 1ファイルにつき複数あってもOK
- 以下、`###`、`####`、... と続く

## 箇条書き

- 箇条書き
  - ネストされた箇条書き
- 箇条書き
- 箇条書き
- 箇条書き

## 番号つきリスト

1. 番号付きリスト
2. 番号付きリスト
3. 番号付きリスト

## コードブロック

本文中でコードを示す場合は、バッククォートで囲みます。

例: `echo "Hello, World!"`

複数行からなるコードは、バッククォート3つで囲んで表現します (コードブロック)。

Linuxコマンドの実行例:

```shell
$ echo "Hello, World!"
Hello, World!
```

シェルスクリプトの例:

```bash
#!/usr/bin/env bash
set -eou pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <name>"
    exit 1
fi
echo "Hello, $1!"
```

Pythonスクリプトの例:

```python
import numpy as np

def main():
    x = []
    for i in range(1, 4):
        x.append(i)
    x = np.array(x)
    print("Numpy array:", x)

if __name__ == "__main__":
    main()
```

## 画像の挿入

画像ファイルは以下のように参照できます。

![画像の説明](path/to/image.png)

- `画像の説明` は画像が表示されない場合に出るテキストです。必須ではありません。
- `path/to/image.png` はリポジトリ内の画像ファイルへの相対パスです。
  - 画像ファイルとMarkdownファイルが同じディレクトリにある場合、単に `image.png` と書けます。
````

### 画像ファイルの扱い

第3回で述べますが、Gitで画像ファイルを管理するのはあまり推奨されません。しかし、利便性は高いため、本コースの課題提出では画像ファイルもリポジトリに含めて提出して構いません。

例えば、以下のような場合には、スクリーンショットを取って添付すると便利です。

- エラー画面の状況を説明したい場合
- GitHubやVS Codeなど、画面上の状態そのものを示す必要がある場合
- グラフやGUI出力など、テキストでは表しにくい結果を示す場合

## 課題

以下の課題への回答を、課題提出用リポジトリ `is-isee/training_course_2026-アカウント名` の `01_linux_intro/assignment.md` に記述して提出してください。

### 課題1: ターミナル操作のショートカット

以下の操作をターミナル上で実行し、**なるべく少ないキーストロークで**完了させてください。

```shell
$ echo "This is a very very long command for practice"
This is a very very long command for practice
$ echo "This is yet another very very long command for practice"
This is yet another very very long command for practice
$ echo "This is a command for practice"
This is a command for practice
```

利用したショートカットとその説明を記述してください。

### 課題2: 環境変数

1. `bash` コマンドのファイル名を確認してください。
2. 1の場所に `bash` というファイルが存在することを確認してください。
3. 1の場所が環境変数 `PATH` に含まれていることを確認してください。

利用したコマンドとその説明を記述してください。

### 課題3: ヘルプの利用

`man` または `--help` オプションの出力を元に、以下の質問に答えてください。

1. コマンド `ls` は何を目的とするコマンドでしょうか。
2. コマンド `ls` でファイルサイズを人間に読める単位 (human readable) で表示するには、どのオプションを使えばいいでしょうか。

### 課題4: コマンドのエラー

以下のコマンドを実行し、出力されるエラーメッセージを読んでそれぞれの意味を説明してください。

```shell
$ ls no_such_file.txt
$ not_a_real_command
$ rm
$ cd /no/such/dir
```
