# Gitを使ってみよう

## Gitリポジトリとは

リポジトリとは、データや情報を保存・管理する場所やシステムを指す言葉です。
Gitリポジトリとは、プロジェクトのソースコードやファイル、変更履歴を保存しておく場所で、プロジェクトの一番上のディレクトリの `project/.git` という隠しディレクトリがその本体です。

## 基礎的なGitコマンドの一覧

- リポジトリの作成: `git init`
- ファイルの追加: `git add <files>`
  - 空ディレクトリは無視される
- 変更されたファイルの確認: `git status`
- 変更されたファイルの差分: `git diff`
- 履歴の記録: `git commit <files>`
  - 環境変数の設定: `EDITOR`
- 履歴の閲覧: `git log`
- 履歴の比較: `git diff [<hash>]`

## プロジェクトの作成

```bash
# project/ というディレクトリを作成
$ mkdir project
$ cd project

# 中にいくつかファイルを作成
$ echo "# My Project" > README.md
$ echo "print('Hello, world!')" > main.py
$ mkdir libs # 空のディレクトリも作成してみる

# 現在のディレクトリ構成を確認
$ ls -A
README.md main.py libs/
```

## Gitリポジトリの作成 `git init`

```bash
# カレントディレクトリにGitリポジトリを初期化 (.git ディレクトリが作成される)
$ git init
Initialized empty Git repository in /path/to/project/.git/
```

この時点ではまだどのファイルも登録されておらず、バージョン管理は始まっていません。
Gitの管理化に置かれた作業用のディレクトリ(上の例なら`project/`)を**ワーキングディレクトリ**と呼びます。

## Gitリポジトリへファイルを登録 `git add`、`git status`、`git commit`

```bash
# ファイルの追加 (ステージング)
# README.md と main.py をステージングエリアに追加
$ git add README.md main.py
# 注意: git add . とするとカレントディレクトリ以下の変更を全て追加できる
# 注意: 空のディレクトリ (libs/) はGitの管理対象にならず、addしても無視される

# 変更されたファイル(ステージングされたファイル)の確認
# Gitリポジトリの状態を確認
$ git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   README.md
        new file:   main.py

# 履歴の記録 (コミット)
# ステージングされた変更をコミット (変更履歴を記録)
# -m オプションでコミットメッセージを直接指定できる
$ git commit -m "最初のコミット: READMEとmain.pyを追加"
[main (root-commit) abc1234] 最初のコミット: READMEとmain.pyを追加
 2 files changed, 2 insertions(+)
 create mode 100644 README.md
 create mode 100644 main.py
```

なお、`-m` を付けずに `git commit` を実行すると、環境変数 `EDITOR` で指定されたエディタが起動し、より詳細なコミットメッセージを入力できます (例: `export EDITOR=vim`)

## 履歴の閲覧 `git log`

```bash
# さらにファイルを変更
$ echo "A library file" > libs/utils.py
$ echo "print('Goodbye!')" >> main.py

# 変更したファイルをステージング
$ git add libs/utils.py main.py
# Tips: git add . や git add -A で変更・追加されたファイルをまとめてステージングできる

# 状態を確認
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   libs/utils.py
        modified:   main.py

# 2回目のコミット
$ git commit -m "ユーティリティファイルを追加し、main.pyを更新"
[main def5678] ユーティリティファイルを追加し、main.pyを更新
 2 files changed, 2 insertions(+)
 create mode 100644 libs/utils.py

# コミット履歴を表示 (新しい順)
$ git log
commit def567890abcdef1234567890abcdef1234567 (HEAD -> main)
Author: Your Name <your.email@example.com>
Date:   Wed Apr 9 13:38:00 2025 +0900

    ユーティリティファイルを追加し、main.pyを更新

commit abc1234567890abcdef1234567890abcdef12 (最初のコミット)
Author: Your Name <your.email@example.com>
Date:   Wed Apr 9 13:37:00 2025 +0900

    最初のコミット: READMEとmain.pyを追加
```

## 履歴の比較 (差分表示) `git diff`

```bash
# 直前のコミット (HEAD^) とその前のコミット (HEAD^^) の差分を表示
# HEAD は最新のコミットを指す
$ git diff HEAD^ HEAD
# またはコミットハッシュを指定 (最初の7文字程度で十分な場合が多い)
$ git diff abc1234 def5678
diff --git a/libs/utils.py b/libs/utils.py
new file mode 100644
index 0000000..9e81a38
--- /dev/null
+++ b/libs/utils.py
@@ -0,0 +1 @@
+A library file
diff --git a/main.py b/main.py
index 3a1bca1..f8c0d9f 100644
--- a/main.py
+++ b/main.py
@@ -1,2 +1,3 @@
 print('Hello, world!')
 print('Hello, Git!')
+print('Goodbye!')

# 特定のコミット (例: 最初のコミット) と現在のワーキングディレクトリの差分を表示
$ git diff abc1234
diff --git a/libs/utils.py b/libs/utils.py
new file mode 100644
index 0000000..9e81a38
--- /dev/null
+++ b/libs/utils.py
@@ -0,0 +1 @@
+A library file
diff --git a/main.py b/main.py
index e7179c1..f8c0d9f 100644
--- a/main.py
+++ b/main.py
@@ -1 +1,3 @@
 print('Hello, world!')
+print('Hello, Git!')
+print('Goodbye!')

# ワーキングディレクトリを少し変更してみる
$ echo "add new line" >> README.md

# 最新コミット(HEAD)とワーキングディレクトリの差分を表示
$ git diff HEAD
diff --git a/README.md b/README.md
index df079ab..6a3a5d2 100644
--- a/README.md
+++ b/README.md
@@ -1 +1,2 @@
 # My Project
+add new line
```
