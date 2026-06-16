# 第2回: Linuxコマンドによるファイル操作

**執筆中**

## Linuxコマンドによるファイル操作

以下の内容を学習してください。

- [ファイル・ディレクトリの操作](../linux/file_and_directory.md)
- [テキストファイルの操作](../linux/text_file.md)

## 課題

以下の課題への回答を、課題提出用リポジトリ `is-isee/training_course_2026-アカウント名` の `02_linux_file_operation/assignment.md` に記述して提出してください。

### 課題1: ファイルとディレクトリの操作

以下のようなファイル・ディレクトリ構成をLinuxコマンドを用いて作成してください。

```shell
linux_practice/
├── memo/
│   ├── note1.txt
│   └── note2.txt
└── data/
    ├── sample1.txt
    ├── sample2.txt
    └── sample3.log
```

`ls -R linux_practice` の出力、作成に利用したコマンド及びその説明を記述してください。

### 課題2: ファイルのコピー・移動・名前変更

課題1で作成した `linux_practice` の中で、以下を行ってください。

1. `data/sample1.txt` を `memo/sample1_backup.txt` としてコピーする。
2. `data/sample2.txt` を `data/result.txt` に名前変更する。
3. `data/sample3.log` を `memo/` に移動する。
4. 最後に `find linux_practice -type f` を実行し、結果を `report.md` に貼り付ける。

実行したコマンド及びその説明を記述してください。
