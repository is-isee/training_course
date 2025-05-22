# リモートリポジトリの活用

## バックアップの重要性: 物理的に異なる場所への保管

ソースコードや研究資料を物理的に一箇所に置いておくことは非常に危険で、誤って削除してしまう、PCが故障してしまう、といった事故により数カ月〜数年にわたる研究成果を紛失してしまう可能性があります。
そこで必要となるのがバックアップで、近年ではDropboxやGoogle Drive、OneDrive、iCloudなど多くのクラウドストレージサービスが利用できます。Gitはバージョン管理のみならず、バックアップに便利な機能である**リモートリポジトリ**という仕組みを持ちます。

## リモートリポジトリの作成 `git remote`、`git push`

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

## リモートリポジトリの複製と同期 `git clone`、`git pull`

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

## 不要なファイルは登録しない `.gitignore`

コード開発や研究遂行において、オブジェクトファイルや可視化結果などGitで管理する必要がない生成物が発生します。これらのファイル、特に画像や動画のようなサイズの大きいファイルを`commit`してしまうとリポジトリの動作が非常に緩慢になってしまいます。プロジェクトの一番上のディレクトリに設定ファイル`.gitignore`を作成すると、ワイルドカードを使った`glob`パターンにマッチしたファイル・ディレクトリは`git add`で追加できなくなり、Gitによるバージョン管理から除く事ができます。様々なプロジェクトに向けた`.gitignore`の例は <https://github.com/github/gitignore> で公開されています。
