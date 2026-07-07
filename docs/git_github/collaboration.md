# 共同開発を始めよう

## ブランチとは

Gitの**ブランチ**とは、コード内の作業履歴を分岐して記録する機能です。複数の作業を並行する際に、作業履歴を分岐させることで、互いの作業に影響を与えずに作業を進めることができます。
特に最初に作られた開発の本流となるブランチ (`main` や `master`) を**メインブランチ**と呼びます。

**注意**: この記事で紹介する公式ドキュメントの図ではメインブランチを `master` と表記されていますが、現在はメインブランチに `main` が使われることが多いです。本資料では適宜 `master` を `main` と読み替えてください。

## ブランチ操作の概要

公式ドキュメント <https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell> から、いくつかブランチの概念図を紹介します。

まず、初期状態では、`master` ブランチで作業していたとしましょう。

```shell
$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

実験のため、`testing` ブランチが必要となり、以下のコマンドで新しいブランチを作成しました。

```shell
$ git branch testing
```

![2つのブランチ](https://git-scm.com/book/en/v2/images/head-to-master.png)

このとき、`master` ブランチと `testing` ブランチが並行して存在しています。
ここで、`HEAD` という特殊なポインタがあります。`HEAD` は現在作業中のブランチを指しており、上の図では `master` ブランチを指しています。
`git branch testing` コマンドを実行した直後は、まだ `testing` ブランチではなく `master` ブランチで作業を続けている状態です。

ここで、以下のコマンドを実行して、`HEAD` を `testing` ブランチに切り替えます。

```shell
$ git switch testing
```

![HEADがtestingを指している](https://git-scm.com/book/en/v2/images/head-to-testing.png)

上の図は、`HEAD` が `testing` ブランチを指すようになった状態です。

ここで、以下のようにファイルを変更してみましょう。

```shell
$ vi test.py
$ git add test.py
$ git commit -m 'Make a change'
```

![testingブランチの変更後](https://git-scm.com/book/en/v2/images/advance-testing.png)

`testing` ブランチで変更を加えたため、`HEAD` が指す `testing` ブランチのコミット履歴が更新されました。ただし、`master` ブランチのコミット履歴は変更されていません。

この状態で、以下のコマンドを実行して `HEAD` ポインタを `master` ブランチに変更しましょう。

```shell
$ git switch master
```

![HEADがmasterブランチを指した状態](https://git-scm.com/book/en/v2/images/checkout-master.png)

この状態では、`master` ブランチの `test.py` は何も変更されていない状態です。
以下のコマンドを実行すると、`testing` ブランチの変更が `master` ブランチに統合されます。

```shell
$ git merge testing
```

作業後に不要になった `testing` ブランチは、以下のコマンドで削除できます。

```shell
$ git branch -d testing
```

これが一連のブランチ操作の流れです。

## コンフリクト

もし別のブランチで作業している間に、メインブランチ側でも変更が進んでいたらどうなるでしょうか。多くの場合、`git merge` により Git は両方の変更を自動で統合できます。しかし、同じファイルの同じ箇所が別々の内容に変更されている場合、Git はどちらを採用すべきか判断できません。この状態をコンフリクトと呼びます。

![複数ブランチの並行作業の例](https://git-scm.com/book/en/v2/images/basic-merging-1.png)

上図では、`master` ブランチと `iss53` ブランチで、それぞれ個別のコミット履歴 (C3, C4, C5) が作られています。この状態で、`master` ブランチに `iss53` ブランチの変更を統合しようとして、例えば以下のようなメッセージが表示されました。

```shell
$ git switch master
$ git merge iss53
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```

この状態をコンフリクトと呼びます。コンフリクトが発生すると、Gitは自動で変更を統合できず、手動で解決する必要があります。コンフリクトが発生したファイル (上の例では `index.html`) には、以下のようなマーカーが挿入されます。

```html
<<<<<<< HEAD:index.html
<div id="footer">contact : email.support@github.com</div>
=======
<div id="footer">
 please contact us at support@github.com
</div>
>>>>>>> iss53:index.html
```

これは、`HEAD` (`master` ブランチ) と `iss53` ブランチの変更箇所を示しています。`<<<<<<<` と `=======` の間が `HEAD` の内容、`=======` と `>>>>>>>` の間が `iss53` の内容です。
コンフリクトをおこしたファイル (`index.html`) をエディタで開き、以下のように編集しましょう。

```html
<div id="footer">
please contact us at email.support@github.com
</div>
```

これは、`iss53` の変更を残しつつ、アドレスは `master` のものを採用した例です。コンフリクトを解決したら、以下のコマンドで変更をステージングし、コミットします。

```shell
$ git add index.html
$ git commit -m 'Resolve merge conflict in index.html'
```

## 共同開発におけるブランチ

共同開発では、`main` ブランチを直接編集するのではなく、作業ごとに新しいブランチを作成して変更を加えることが一般的です。

例えば、新しい機能を追加する場合は、以下のように作業用ブランチを作成して、そのブランチに移動します。

```shell
$ git switch -c feature/add-new-feature
Switched to a new branch 'feature/add-new-feature'
```

この状態でファイルを編集し、通常どおり `add` と `commit` を行います。

```shell
$ git add .
$ git commit -m 'Add new feature'
```

ここまでの変更は、まだ自分のPC上のローカルリポジトリにしか存在しません。他の人と共有したり、GitHub上でプルリクエストを作成したりするには、作業ブランチをリモートリポジトリに `push` する必要があります。

```shell
$ git push -u origin feature/add-new-feature
```

ここで `origin` はリモートリポジトリの名前です。多くの場合、GitHub上のリポジトリを指します。

また、`-u` は `--set-upstream` の短縮形で、ローカルブランチとリモートブランチを対応づけるためのオプションです。これを一度設定しておくと、次回以降はブランチ名を省略して次のように実行できます。

```shell
$ git push
```

また、リモートリポジトリ側の変更を取得する場合も、次のように実行できます。

```shell
$ git pull
```

このように、ローカルブランチとリモートブランチを対応づけておくと、共同開発での作業が簡単になります。

## リモートブランチとは

**リモートブランチ**とは、GitHubなどのリモートリポジトリ上に存在するブランチのことです。

例えば、自分のPC上にある `feature/add-new-feature` はローカルブランチですが、GitHub上にある `feature/add-new-feature` はリモートブランチです。

Gitでは、リモートブランチの状態をローカル側で `origin/feature/add-new-feature` のような名前で参照します。

```shell
$ git branch -r
  origin/master
  origin/feature/add-new-feature
```

ただし、`origin/feature/add-new-feature` は「リモートブランチそのもの」ではなく、「最後に取得したリモートブランチの状態」を表す情報です。そのため、リモート側でブランチが削除されても、ローカルに古い情報が残ることがあります。

このようなローカルに残ってしまった古いリモートブランチ情報を整理したい場合は、次のように実行します。

```shell
$ git fetch -p
```

`-p` は `--prune` の短縮形で、リモートリポジトリにはもう存在しないブランチ情報をローカルから削除します。

なお、これはローカルブランチを削除する操作ではありません。不要になったローカルブランチを削除する場合は、別途次のように実行します。

```shell
$ git branch -d feature/add-new-feature
```

## ブランチ名の例

共同開発では、ブランチ名を見るだけで何の作業をしているか分かるようにしておくと便利です。

例えば、以下のような名前がよく使われます。

```text
feature/add-new-feature
fix/minor-bug
docs/update-readme
```

複数人で同じリポジトリを使う場合は、ユーザー名を先頭につけることもあります。

```text
is-isee/add-new-feature
is-isee/fix-minor-bug
```

どの命名規則を使うかはプロジェクトによって異なります。共同開発では、そのプロジェクトの方針に従うようにしましょう。

## GitHubの機能: イシューとプルリクエスト

GitHubでは、作業内容を管理するために**イシュー**と**プルリクエスト**がよく使われます。

**イシュー**は、バグ修正・機能追加・ドキュメント改善などの課題を記録するための機能です。
例えば、このリポジトリのイシューは <https://github.com/is-isee/training_course/issues> で確認出来ます。

**プルリクエスト**は、自分のブランチで行った変更を、`main` ブランチなどに取り込んでもらうための提案です。共同開発では、プルリクエスト上でコードレビューや議論を行ってから、変更をマージすることが一般的です。
例えば、 <https://github.com/is-isee/MISO/pulls> で `Closed` となっているプルリクエストを見ると、どのような変更が行われたか、どのような議論があったかを確認できます。

## 演習: イシューとプルリクエスト

以下の流れで、GitHub上での開発フローを体験してみましょう。

1. GitHub上でイシューを作成する
2. イシューに対応する作業用ブランチを作成する
3. ファイルを編集し、変更をコミットする
4. 作業ブランチを同名のリモートリポジトリにpushし、プルリクエストを作成する
   - 方法1: `gh pr create` コマンドにより、pushとプルリクエスト作成を同時に実行
   - 方法2: `git push -u origin branch_name` し、ブラウザでプルリクエストを作成
5. プルリクエストを `main` ブランチにマージする (ブラウザ上で可能です)
6. 不要になったブランチを削除する

実際の共同開発では、手順4と5の間にコードレビューや議論が行われることが多いです。プルリクエストを作成したら、他の開発者にレビューを依頼し、必要に応じて修正を加えます。

コミットメッセージやプルリクエストの本文に `fix #37` や `close #37` のように書くと、プルリクエストがマージされたときに対応するイシューを自動で閉じることができます。

このように、イシューで作業内容を管理し、ブランチで変更を分け、プルリクエストで変更を確認してからマージする流れは、GitHubを使った共同開発でよく使われる方法です。
