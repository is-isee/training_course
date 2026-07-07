# 第3回: Git/GitHub入門

## Git/GitHub入門

以下の内容を学習してください。

- [バージョン管理とGit](../git_github/versioning.md)
- [Gitを使ってみよう](../git_github/git_local.md)
- [リモートリポジトリの活用](../git_github/git_remote.md)
- [GitHubを使ってみよう](../git_github/github.md)
- [共同開発を始めよう](../git_github/collaboration.md)

## 課題

以下の課題へ取り組んでください。第3回では作業内容を課題提出用リポジトリで確認しますので、個別にレポートファイルを書く必要はありません。代わりに、課題提出用リポジトリそのものを操作し、GitHub上に変更履歴・Issue・Pull Requestを残すことで、課題の提出とします。

ただし、GitHubのアクセストークン、認証コード、秘密鍵などは提出物に含めないでください。`gh auth status` などの出力を載せる場合、Tokenの行は省略または伏字にしてください。

質問等があれば、課題提出用リポジトリに質問用のIssueを作成し、講師 `@iijimahr` にメンションしてください。

### 課題1: 課題提出用リポジトリをcloneしてファイルを作成する

自分の課題提出用リポジトリをローカル環境に `clone` してください。

その後、課題提出用リポジトリの中に、以下のようなファイル・ディレクトリ構成を作成してください。

```shell
03_git_github/
├── profile.md
├── notes/
│   └── git_commands.md
└── src/
    └── hello_git.py
```

各ファイルには、例えば以下のような内容を書いてください。内容は自分で適宜変更して構いません。

```markdown
# profile.md

# Profile

- 名前:
- GitHubアカウント:
- Git/GitHubで不安なこと:
- ひとこと:
```

```markdown
# notes/git_commands.md

# Git commands

## よく使うGitコマンド

- `git status`:
- `git add`:
- `git commit`:
- `git push`:
- `git pull`:
```

```python
# src/hello_git.py

print("Hello, Git/GitHub")
```

ファイルを作成したら、以下を行ってください。

1. `git status` で状態を確認する。
2. 作成したファイルを `git add` でステージングする。
3. `git commit` で変更をコミットする。
4. `git push` でGitHub上の課題提出用リポジトリに反映する。
5. GitHub上で、作成したファイルが表示されていることを確認する。

### 課題2: 作業用ブランチを作成してPull Requestを作成する

課題1では `main` ブランチに直接pushしました。次は、共同開発でよく使われる「作業用ブランチを作成し、Pull Requestを通じて変更を取り込む」流れを体験します。

まず、ローカルで作業用ブランチを作成し、そのブランチに移動してください。ブランチ名は、例えば以下のようにしてください。

```shell
git switch -c docs/update-git-notes
```

作業用ブランチで、`03_git_github/notes/git_commands.md` に以下の内容を追記してください。

1. `git branch` または `git switch` の説明
2. `git log` または `git diff` の説明
3. 今回の課題で自分がよく使ったGitコマンドのメモ

変更後、以下を行ってください。

1. `git status` で状態を確認する。
2. 変更を `git add` でステージングする。
3. `git commit` で変更をコミットする。
4. 作業用ブランチをGitHubに `push` する。
5. GitHub上でPull Requestを作成する。
6. Pull Requestの内容を確認し、自分で `main` ブランチにマージする。
7. マージ後、ローカルの `main` ブランチに戻り、`git pull` で最新の状態を取得する。

Pull Requestの本文には、以下の内容を含めてください。Markdown形式で書くと見やすいです。

- 変更内容
- 確認したこと
- 不安な点・確認してほしい点

### 課題3: 講師からのPull Requestを確認してマージする (希望者のみ)

この課題は、希望者のみが取り組む課題です。課題1と課題2を完了した後に取り組んでください。
課題の提出締め切り後に取り組んでも構いません。

課題3に関するイシューを作成し、講師にメンションしてPull Requestの送付を依頼してください。
提出連絡用Issueのコメント欄で、課題3に取り組みたい旨を講師に伝えても構いません。

Pull Requestでは、課題1または課題2で作成したファイルと同じファイルが変更されている場合があります。Gitが自動でマージできる場合もありますが、同じファイルの同じ箇所が異なる内容に変更されている場合は、コンフリクトが発生することがあります。

以下を行ってください。

1. 講師から送られたPull Requestの変更内容を確認する。
2. マージできる場合は、Pull Requestをマージする。
3. コンフリクトが発生している場合は、GitHub上またはローカル環境でコンフリクトを解決する。
4. コンフリクトを解決した後、Pull Requestをマージする。
5. マージ後、ローカルの `main` ブランチで `git pull` を実行し、最新の状態を取得する。

## 提出連絡

課題1〜2が完了したら、自分の課題提出用リポジトリでIssueを作成し、講師 `@iijimahr` にメンションして提出完了を知らせてください。

Issueのタイトルは、例えば以下のようにしてください。

```text
第3回 Git/GitHub入門 課題提出
```

Issueの本文には、以下の内容を含めてください。Markdown形式で書くことが出来ます。

```markdown
@iijimahr

第3回 Git/GitHub入門の課題を提出しました。

## 実施内容

- 課題1: 課題提出用リポジトリをcloneし、ファイルを作成してpushしました。
- 課題2: 作業用ブランチを作成し、Pull Requestを作成・マージしました。
- 課題2で作成したPull RequestのURL:

## コメント・質問 (あれば)

-
```
