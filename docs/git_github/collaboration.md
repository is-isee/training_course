# 共同開発を始めよう

## ブランチとは

Gitの**ブランチ**とは、コード内の作業履歴を分岐して記録する機能です。複数の作業を平行する際に、作業履歴を分岐させることで、互いの作業に影響を与えずに作業を進めることができます。
特に最初に作られた開発の本流となるブランチ (`main` や `master`) を**メインブランチ**と呼びます。

## ローカルブランチの作成と移動 `git branch`、`git switch`

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

## リモートブランチの作成と削除 `git push -u/--set-upstream`、`git push -d/--delete`、`git pull -p/--prune`

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

## 共同開発におけるブランチの命名規則

共同開発を行う場合、そのプロジェクトの方針に従うことが原則で、ブランチの命名規則も同様です。
例として、`user/issue37` や `user/add-xxx-feature` のようにユーザー名を先頭につけるものは、誰が作業中か明らかで、またブランチ名の衝突も防ぎやすいため、よく利用される命名規則の一つです。

## イシューとプルリクエスト

**イシュー (issue)**と**プルリクエスト (pull request; PR)**はどちらもGitHubなどの開発ツールで利用できる機能です。
イシューは課題やタスクを管理する機能、プルリクエストは変更を提案・議論する機能です。

## 演習: イシューとプルリクエストを送る

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
