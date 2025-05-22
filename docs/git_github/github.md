# GitHubを使ってみよう

GitHubはソフトウェア開発のプラットフォームで、本コースの執筆時点で8000万件以上(出典: <https://github.co.jp/>)のプロジェクトがホスティングされています。

多くのオープンソースプロジェクトにおいて、コード公開の場所として最初の選択肢に入るのがGitHubです。蛇足ですが、Gitとよく混同されやすいので注意してください。

## 演習: GitHubでプロジェクトを作成・編集

1. GitHubアカウントに各自のPCの公開鍵を登録 (登録していない場合)
2. GitHubのWeb UI (ユーザーインターフェース)で新規リポジトリを作成
3. 作成したリポジトリを`clone`
4. ローカルでファイルを編集・追加
5. GitHub上のリモートリポジトリへ`push`
6. Web UIで`push`した内容が反映されていることを確認

## 演習: GitHub CLIでGitHubにログイン

上の例ではGitHubアカウントに公開鍵を登録しましたが、 GitHub のコマンドラインツールである GitHub CLI を用いると公開鍵を使わずに直感的な方法で GitHub に各自のPCを認証させることができます。

1. [GitHub CLI](https://cli.github.com/) を各自のPCにインストール
2. 各自のPCで `gh auth login` としてGitHubへログイン

GitHub CLIはログイン以外にも[様々な機能](https://cli.github.com/manual/)があるので各自で調べてみてください。
