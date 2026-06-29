# 第2回: Linuxコマンドによるファイル操作

## Linuxコマンドによるファイル操作

以下の内容を学習してください。

- [ファイル・ディレクトリの操作](../linux/file_and_directory.md)
- [テキストファイルの操作](../linux/text_file.md)

## 課題

以下の課題への回答を、課題提出用リポジトリの `02_linux_file_operation/assignment.md` に記
述して提出してください。
「実行したコマンドと出力」については、ターミナルのコピー&ペーストやスクリーンショットなどを活用して、適宜省力化して構いません。

### 課題1: ファイルとディレクトリの作成

以下のようなファイル・ディレクトリ構成を Linux コマンドを用いて作成してください。
ファイルの中身は空で構いません。

```shell
linux_practice/
├── memo/
│   ├── note1.txt
│   └── note2.txt
└── data/
    ├── sample1.txt
    ├── sample2.txt
    └── sample3.txt
```

作成後、以下のコマンドを実行してください。

```shell
$ ls -R linux_practice
```

提出物には、以下を記述してください。

1. 実行したコマンドと出力
2. 主要な利用コマンドの簡単な説明

### 課題2: ファイルのコピー・移動・名前変更・検索

課題1で作成した `linux_practice` の中で、以下を行ってください。

1. `data/sample1.txt` を `memo/sample1_backup.txt` としてコピーする。
2. `data/sample2.txt` を `data/result.txt` に名前変更する。
3. `data/sample3.txt` を `memo/` に移動する。
4. `memo/note1.txt` へのシンボリックリンク `data/link_to_note1.txt` を作成する。
   作成後、`cat linux_practice/data/link_to_note1.txt` でリンク先の中身を読めることを確認する。
5. `find linux_practice -type f` を実行し、通常ファイルの一覧を確認する。
6. `find linux_practice -type l` を実行し、シンボリックリンクの一覧を確認する。

提出物には、以下を記述してください。

1. 実行したコマンドと出力
2. コピー、移動、名前変更、シンボリックリンクの違いについての簡単な説明

### 課題3: テキストファイルの作成・置換・比較・集計

まず、以下のコマンドを使って `data.txt` を作成してください。

```shell
$ printf "apple 80 red\nbanana 120 yellow\napple 80 red\ncherry 150 red\n" > data.txt
```

次に、以下を行ってください。

1. `cat` または `less` を使って、`data.txt` の中身を確認する。
2. `awk` を使って、`data.txt` の1列目と3列目だけを表示する。
3. `awk` を使って、2列目が100より大きい行だけを表示する。
4. `sort data.txt | uniq -c` を実行し、重複行を集計する。
5. `sed` を使って、`apple` を `orange` に置換したファイル `data_replaced.txt` を作成する。
6. `diff data.txt data_replaced.txt` を実行し、置換前後の差分を確認する。

提出物には、以下を記述してください。

1. 実行したコマンドと出力
2. `awk`, `sort`, `uniq`, `sed`, `diff` がそれぞれ何をしているかの簡単な説明

### 課題4: 不可視文字のセキュリティリスク

不可視文字や Unicode 文字に関連するセキュリティリスクについて、以下の3つの事例を調査し、どれか1つについて1段落程度で概要をまとめてください。

- Trojan Source
- GlassWorm
- 見えないプロンプトインジェクション

概要には、「何が見えにくいのか」「なぜ危険なのか」「どのような対策があるか」を含めてください。
また、調査に利用した記事や資料の出典 (URLなど) を記載してください。
