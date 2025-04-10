# バージョン管理 Git/GitHub

## バージョン管理とGit

### バージョン管理の必要性

**変更履歴の可視化と追跡**: コード開発では一気に完成版まで持っていけることはまれで、実際には多くの試行錯誤が必要になります。場合によっては、ある時点までは発生しなかったバグがいつの間にか発生するようになった、といったこともあります。コードをバージョンごとに分けて管理していれば、どの時点でバグが混入したのか発見することが容易になります。

**同時並行での開発(共同開発)**: 複数人で同じコードを開発すると、誰がどのバージョンをどのように変更しているか混乱がしやすくなります。Gitのようなバージョン管理システムには共同開発用の機能が盛り込まれています。

**複数バージョンの管理**: 研究の遂行にあたって、研究対象や研究フェーズによってコードのバージョンを変更したい場合があります。バージョン管理システムを利用していればそのような要求にも容易に対応できます。

**科学研究の再現性確保**: 研究の再現性とは、同じ方法と条件で実施した際に同じ結果が得られることを意味します。研究の再現性確保のためにまず挙げられるのが研究ノートの作成ですが、バージョン管理システムを用いると特にコード開発における研究ノートの役割を一部代替することができます。

### 原始的なバージョン管理

原始的なバージョン管理方法の例は、ディレクトリに日付や番号をつけて管理する方法です。

```bash
# project/ というディレクトリにバージョン管理したいコードを保存
$ ls project/
README.md libs.py main.py 

# project/ を project_2025-04-01/ という別名で保存
$ cp -r project project_2025-04-01

# バージョン間の比較
$ diff -r project_2025-04-01 project_2025-03-01
```

しかし、このような原始的な方法は一日に複数回バージョンを保存できない、古いディレクトリの保存・管理が大変、ディレクトリの命名規則を変更したい際に手間、コードを変更した際に関連する作業への反映が煩雑になる、といった多くの問題点が存在します。
Gitのようなバージョン管理システムを使うと、その多くの問題を回避することができます。

## Gitを使ってみよう

### Gitリポジトリとは

リポジトリとは、データや情報を保存・管理する場所やシステムを指す言葉です。
Gitリポジトリとは、プロジェクトのソースコードやファイル、変更履歴を保存しておく場所で、プロジェクトの一番上のディレクトリの `project/.git` という隠しディレクトリがその本体です。

### 基礎的なGitコマンドの一覧

- リポジトリの作成: `git init`
- ファイルの追加: `git add <files>`
  - 空ディレクトリは無視される
- 変更されたファイルの確認: `git status`
- 変更されたファイルの差分: `git diff`
- 履歴の記録: `git commit <files>`
  - 環境変数の設定: `EDITOR`
- 履歴の閲覧: `git log`
- 履歴の比較: `git diff [<hash>]`

### プロジェクトの作成

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

### Gitリポジトリの作成 `git init`

```bash
# カレントディレクトリにGitリポジトリを初期化 (.git ディレクトリが作成される)
$ git init
Initialized empty Git repository in /path/to/project/.git/
```

この時点ではまだどのファイルも登録されておらず、バージョン管理は始まっていません。
Gitの管理化に置かれた作業用のディレクトリ(上の例なら`project/`)を**ワーキングディレクトリ**と呼びます。

### Gitリポジトリへファイルを登録 `git add`、`git status`、`git commit`

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

### 履歴の閲覧 `git log`

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

### 履歴の比較 (差分表示) `git diff`

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

## リモートリポジトリの活用

### バックアップの重要性: 物理的に異なる場所への保管

ソースコードや研究資料を物理的に一箇所に置いておくことは非常に危険で、誤って削除してしまう、PCが故障してしまう、といった事故により数カ月〜数年にわたる研究成果を紛失してしまう可能性があります。
そこで必要となるのがバックアップで、近年ではDropboxやGoogle Drive、OneDrive、iCloudなど多くのクラウドストレージサービスが利用できます。Gitはバージョン管理のみならず、バックアップに便利な機能である**リモートリポジトリ**という仕組みを持ちます。

### リモートリポジトリの作成 `git remote`、`git push`

**リモートリポジトリ**とは、ワーキングディレクトリの外側(多くの場合はネットワーク上の別のサーバ)に存在するリポジトリのことを指します。対照的に、開発者が自身の環境に作成・複製するワーキングディレクトリ内のリポジトリ(上の例では`project/.git`)のことを**ローカルリポジトリ**と呼びます。

以下では、空の**ベアリポジトリ**(ワーキングディレクトリを持たないGitの更新情報だけを持っているリポジトリ)を作成し、これをリモートリポジトリとしてローカルリポジトリに登録しています。
同じ計算機内にローカルリポジトリとリモートリポジトリが共存する、教育用の特殊な例です。

```bash
# project/ ディレクトリにいることを確認
# ここまでで2回のコミットが行われている状態
$ pwd
/path/to/project
$ git log --oneline
def5678 (HEAD -> main) ユーティリティファイルを追加し、main.pyを更新
abc1234 最初のコミット: READMEとmain.pyを追加

# ベアリポジトリの作成
# project/ と同じ階層にリモートリポジトリ用のディレクトリを作成
$ mkdir ../remote_repo
$ cd ../remote_repo

# ベアリポジトリを初期化 (作業ディレクトリを持たないリポジトリ)
# 慣習的にディレクトリ名を .git で終わらせることが多い
$ git init --bare project.git
Initialized empty Git repository in /path/to/remote_repo/project.git/

# ベアリポジトリの中身を確認 (通常の .git ディレクトリの中身と同じ)
$ ls project.git/
HEAD  branches  config  description  hooks  info  objects  refs

# ローカルリポジトリに戻る
$ cd ../project

# リモートリポジトリの登録
# ローカルリポジトリに、先ほど作成したベアリポジトリを 'origin' という名前で登録
# URLにはベアリポジトリへのパスを指定 (相対パスでも絶対パスでも可)
$ git remote add origin ../remote_repo/project.git

# 登録されたリモートリポジトリを確認 (-v オプションでURLも表示)
$ git remote -v
origin  ../remote_repo/project.git (fetch)
origin  ../remote_repo/project.git (push)

# 登録されたリモート名のリストを表示
$ git remote
origin

# リモートリポジトリへのプッシュ
# ローカルの 'main' ブランチの変更履歴を、リモート 'origin' にプッシュ
# -u オプション: ローカルの 'main' ブランチがリモート 'origin' の 'main' ブランチを
#               追跡するように設定 (次回から git push だけでよくなる)
$ git push -u origin main
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 8 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (6/6), 612 bytes | 612.00 KiB/s, done.
Total 6 (delta 0), reused 0 (delta 0), pack-reused 0
To ../remote_repo/project.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.

# プッシュ後の状態確認
# ローカルリポジトリの状態を確認
# リモートリポジトリとの差分がないことがわかる
$ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

# ログを確認 (ローカルの main とリモートの origin/main が同じコミットを指している)
$ git log --oneline --decorate
def5678 (HEAD -> main, origin/main) ユーティリティファイルを追加し、main.pyを更新
abc1234 最初のコミット: READMEとmain.pyを追加

# --- (参考) ベアリポジトリ側の確認 ---
# ベアリポジトリのログを確認することもできる (通常は直接操作しない)
$ git --git-dir=../remote_repo/project.git log --oneline
def5678 (HEAD -> main) ユーティリティファイルを追加し、main.pyを更新
abc1234 最初のコミット: READMEとmain.pyを追加
```

### リモートリポジトリの複製と同期 `git clone`、`git pull`

以下では、先ほど作成したリモートリポジトリ `../remote_repo/project.git` から新たなワーキングディレクトリを作成します。そして、異なるワーキングディレクトリ間のコードをリモートリポジトリを通して同期していきましょう。

```bash
# 現在地を project/ や remote_repo/ の一つ上の階層に移動
$ cd ..
$ ls
project/ remote_repo/

# --- リモートリポジトリの複製 (git clone) ---
# リモートリポジトリ ../remote_repo/project.git の内容を
# 'project_clone' という新しいディレクトリに複製する
$ git clone ../remote_repo/project.git project_clone
Cloning into 'project_clone'...
done.

# 新しく作成されたディレクトリ 'project_clone' に移動
$ cd project_clone

# 中身を確認 (リモートリポジトリのファイルが展開されている)
$ ls -A
.git/  README.md  libs/  main.py

# ログを確認 (リモートリポジトリの履歴がそのままコピーされている)
$ git log --oneline --decorate
def5678 (HEAD -> main, origin/main, origin/HEAD) ユーティリティファイルを追加し、main.pyを更新
abc1234 最初のコミット: READMEとmain.pyを追加

# リモート接続を確認 ('origin' という名前で自動的に登録されている)
$ git remote -v
origin  ../remote_repo/project.git (fetch)
origin  ../remote_repo/project.git (push)

# --- リモート側での変更 (シミュレーション) ---
# ここでは、元の 'project' ディレクトリで変更を加えてリモートに push する
# (別の共同作業者が変更を push した状況を想定)

# 元の 'project' ディレクトリに移動
$ cd ../project

# README.md を変更
$ echo "Update from original project" >> README.md
$ cat README.md
# My Project
Update from original project

# 変更をステージングしてコミット
$ git add README.md
$ git commit -m "元のプロジェクトからREADMEを更新"
[main 123abcd] 元のプロジェクトからREADMEを更新
 1 file changed, 1 insertion(+)

# 変更をリモートリポジトリ 'origin' にプッシュ
$ git push origin main
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 330 bytes | 330.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To ../remote_repo/project.git
   def5678..123abcd  main -> main

# --- クローンしたリポジトリで変更を取得 (git pull) ---
# 'project_clone' ディレクトリに戻る
$ cd ../project_clone

# 現在のローカルの状態を確認 (まだリモートの変更は反映されていない)
$ cat README.md
# My Project
$ git log --oneline --decorate
def5678 (HEAD -> main, origin/main, origin/HEAD) ユーティリティファイルを追加し、main.pyを更新
abc1234 最初のコミット: READMEとmain.pyを追加

# リモート 'origin' の 'main' ブランチから最新の変更を取得し、
# 現在のローカルブランチ (main) にマージする
# (git pull は git fetch + git merge のショートカット)
$ git pull origin main
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 314 bytes | 314.00 KiB/s, done.
From ../remote_repo/project
   def5678..123abcd  main       -> origin/main
Updating def5678..123abcd
Fast-forward
 README.md | 1 +
 1 file changed, 1 insertion(+)

# --- 同期後の状態確認 ---
# 再度ファイルの内容を確認 (リモートの変更が取り込まれている)
$ cat README.md
# My Project
Update from original project

# ログを確認 (ローカルの main とリモートの origin/main が最新のコミットを指している)
$ git log --oneline --decorate
123abcd (HEAD -> main, origin/main, origin/HEAD) 元のプロジェクトからREADMEを更新
def5678 ユーティリティファイルを追加し、main.pyを更新
abc1234 最初のコミット: READMEとmain.pyを追加

# 状態を確認 (最新の状態になっている)
$ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

このようにGitとリモートリポジトリを用いると、異なる場所に存在する同様のプロジェクトで容易に同期を取り、必要な変更を反映することができます。

### 不要なファイルは登録しない `.gitignore`

コード開発や研究遂行において、オブジェクトファイルや可視化結果などGitで管理する必要がない生成物が発生します。これらのファイル、特に画像や動画のようなサイズの大きいファイルを`commit`してしまうとリポジトリの動作が非常に緩慢になってしまいます。プロジェクトの一番上のディレクトリに設定ファイル`.gitignore`を作成すると、ワイルドカードを使った`glob`パターンにマッチしたファイル・ディレクトリは`git add`で追加できなくなり、Gitによるバージョン管理から除く事ができます。様々なプロジェクトに向けた`.gitignore`の例は <https://github.com/github/gitignore> で公開されています。

## GitHubを使ってみよう

GitHubはソフトウェア開発のプラットフォームで、本コースの執筆時点で8000万件以上(出典: <https://github.co.jp/>)のプロジェクトがホスティングされています。

多くのオープンソースプロジェクトにおいて、コード公開の場所として最初の選択肢に入るのがGitHubです。蛇足ですが、Gitとよく混同されやすいので注意してください。

### 演習: GitHubでプロジェクトを作成・編集

1. GitHubアカウントに各自のPCの公開鍵を登録 (登録していない場合)
2. GitHubのWeb UI (ユーザーインターフェース)で新規リポジトリを作成
3. 作成したリポジトリを`clone`
4. ローカルでファイルを編集・追加
5. GitHub上のリモートリポジトリへ`push`
6. Web UIで`push`した内容が反映されていることを確認

### 演習: GitHub CLIでGitHubにログイン

上の例ではGitHubアカウントに公開鍵を登録しましたが、 GitHub のコマンドラインツールである GitHub CLI を用いると公開鍵を使わずに直感的な方法で GitHub に各自のPCを認証させることができます。

1. [GitHub CLI](https://cli.github.com/) を各自のPCにインストール
2. 各自のPCで `gh auth login` としてGitHubへログイン

GitHub CLIはログイン以外にも[様々な機能](https://cli.github.com/manual/)があるので各自で調べてみてください。

## 共同開発を始めよう

### ブランチとは

Gitの**ブランチ**とは、コード内の作業履歴を分岐して記録する機能です。複数の作業を平行する際に、作業履歴を分岐させることで、互いの作業に影響を与えずに作業を進めることができます。
特に最初に作られた開発の本流となるブランチ (`main` や `master`) を**メインブランチ**と呼びます。

### ローカルブランチの作成と移動 `git branch`、`git switch`

```bash
# --- 現在のブランチを確認 ---
# 'git branch' コマンドでローカルブランチの一覧を表示
# '*' が現在チェックアウトしているブランチを示す
$ git branch
* main

# --- 新しいローカルブランチを作成 ---
# 'feature/add-new-feature' という名前のブランチを作成
$ git branch feature/add-new-feature

# 再度ブランチ一覧を表示 (まだ main ブランチにいる)
$ git branch
* main
  feature/add-new-feature

# --- 作成したブランチに移動 ---
# 'git switch' コマンドで 'feature/add-new-feature' ブランチに切り替え
# (古いGitでは 'git checkout feature/add-new-feature' を使用)
$ git switch feature/add-new-feature
Switched to branch 'feature/add-new-feature'

# 現在のブランチが切り替わったことを確認
$ git branch
  main
* feature/add-new-feature

# --- (補足) ブランチ作成と移動を同時に行う ---
# 'fix/minor-bug' というブランチを作成し、同時にそのブランチへ移動する
# (古いGitでは 'git checkout -b fix/minor-bug' を使用)
$ git switch -c fix/minor-bug
Switched to a new branch 'fix/minor-bug'

$ git branch
  main
  feature/add-new-feature
* fix/minor-bug

# 作業のため、元の feature ブランチに戻っておく
$ git switch feature/add-new-feature
Switched to branch 'feature/add-new-feature'
```

### リモートブランチの作成と削除 `git push -u/--set-upstream`、`git push -d/--delete`、`git pull -p/--prune`

リモートリポジトリにおいてもローカルリポジトリと同様にブランチを作成することが可能で、リモートブランチとローカルブランチを同期させることができます。
リモートブランチとローカルブランチの名前は異なっていても問題ありませんが、習慣として、リモートブランチと紐づけられたローカルブランチ名前は同一にする方が誤解が少ないでしょう。

```bash
# --- 前提: feature/add-new-feature ブランチにいる状態 ---
$ git branch
  main
* feature/add-new-feature
  fix/minor-bug

# --- ローカルブランチをリモートにプッシュしてリモートブランチを作成 ---
# 現在のローカルブランチ 'feature/add-new-feature' をリモートリポジトリ 'origin' にプッシュ
# '-u' (または '--set-upstream') オプション:
#   - リモートに同名のブランチがなければ作成する
#   - ローカルブランチがリモートの同名ブランチを追跡するように設定する (upstream設定)
$ git push -u origin feature/add-new-feature
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To ../remote_repo/project.git
 * [new branch]      feature/add-new-feature -> feature/add-new-feature
Branch 'feature/add-new-feature' set up to track remote branch 'feature/add-new-feature' from 'origin'.

# --- リモート追跡ブランチの確認 ---
# 'git branch -r' でリモート追跡ブランチの一覧を表示
$ git branch -r
  origin/HEAD -> origin/main
  origin/main
  origin/feature/add-new-feature # 新しく作成されたリモートブランチの情報

# 'git branch -a' でローカルとリモート追跡ブランチを全て表示
$ git branch -a
* feature/add-new-feature
  fix/minor-bug
  main
  remotes/origin/HEAD -> origin/main
  remotes/origin/main
  remotes/origin/feature/add-new-feature

# --- main ブランチに戻る ---
$ git switch main
Switched to branch 'main'
Your branch is up to date with 'origin/main'.

# --- リモートブランチの削除 ---
# リモートリポジトリ 'origin' 上の 'feature/add-new-feature' ブランチを削除
# '-d' (または '--delete') オプションを使用
$ git push -d origin feature/add-new-feature
To ../remote_repo/project.git
 - [deleted]         feature/add-new-feature

# --- リモート追跡ブランチの情報を整理 ---
# リモートで削除されたブランチの追跡情報がローカルに残っている場合がある
$ git branch -r
  origin/HEAD -> origin/main
  origin/main
  origin/feature/add-new-feature # まだ情報が残っている

# 'git pull --prune' (または 'git pull -p') を実行すると、
# リモートリポジトリに存在しないブランチの追跡情報がローカルから削除される
$ git pull -p
From ../remote_repo/project
 x [deleted]         (none)     -> origin/feature/add-new-feature # 削除されたことを検知
Already up to date.

# 再度リモート追跡ブランチを確認 (削除されている)
$ git branch -r
  origin/HEAD -> origin/main
  origin/main

# ローカルブランチは削除されていないので、不要であれば別途削除する
$ git branch
* main
  feature/add-new-feature # ローカルにはまだ残っている
  fix/minor-bug
$ git branch -d feature/add-new-feature # ローカルブランチを削除
Deleted branch feature/add-new-feature (was XXXXXXX). # コミットハッシュは適宜変わる
```

### 共同開発におけるブランチの命名規則

共同開発を行う場合、そのプロジェクトの方針に従うことが原則で、ブランチの命名規則も同様です。
例として、`user/issue37` や `user/add-xxx-feature` のようにユーザー名を先頭につけるものは、誰が作業中か明らかで、またブランチ名の衝突も防ぎやすいため、よく利用される命名規則の一つです。

### イシューとプルリクエスト

**イシュー (issue)**と**プルリクエスト (pull request; PR)**はどちらもGitHubなどの開発ツールで利用できる機能です。
イシューは課題やタスクを管理する機能、プルリクエストは変更を提案・議論する機能です。

### 演習: イシューとプルリクエストを送る

1. リポジトリに関する何らかの改善案を作成
2. GitHubのWeb UIでイシューを作成
   共同開発の場合、この時にメンテナ(プロジェクトの管理者)との議論が発生する場合もある
3. イシューを自分自身にアサイン
4. 新しいブランチを作成し、イシューを解決するように`commit`  
   この際、コミットメッセージに `fix #37` や `close #37` のようにイシュー番号とキーワードを含めると、手順7でプルリクエストがマージされた際に自動でイシューを閉じることができる([出典](https://docs.github.com/ja/get-started/writing-on-github/working-with-advanced-formatting/using-keywords-in-issues-and-pull-requests))。
5. リモートブランチに`push`
6. GitHubのWeb UIでプルリクエストを作成  
   手順4でイシュー番号をメッセージに含めるのを忘れた場合、この時にイシューとプルリクエストを紐づけることができる([出典](https://docs.github.com/ja/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue))。
7. GitHubのWeb UIでプルリクエストをメインブランチにマージ  
   共同開発の場合、この時にメンテナによるコードレビューが入る。

この開発の流れは GitHub Flow と呼ばれる一般的な Git ワークフローの1つに則ったものです。
