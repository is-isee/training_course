# ヘルプとマニュアル

## コマンドの使い方がわからない時に `man`, `<command> --help`

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

## **演習**: コマンドの使い方を調べてみよう

1. コマンド `ls` は何を目的とするコマンド？
2. コマンド `ls` でサイズを人間に読める単位 (human readable) で表示するには？

## エラーを読むくせをつける

- **エラーメッセージをまず自分で読む**  
  - 何が問題か（ファイルがない、権限がない、引数が不正 など）を把握  
- **検索エンジンやAIに質問**  
  - エラーメッセージ全文をコピーして検索  
  - セキュリティ情報（パスワード、鍵ファイルのパスなど）を含めてはいけません
- **よく見るエラーは記憶しておく**  
  - 慣れてくると一目で原因が分かるようになります

## **演習**: エラーを出してみよう

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
