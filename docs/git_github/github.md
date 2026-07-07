# GitHubを使ってみよう

GitHubはソフトウェア開発のプラットフォームで、本コースの執筆時点で8000万件以上(出典: <https://github.co.jp/>)のプロジェクトがホスティングされています。

多くのオープンソースプロジェクトにおいて、コード公開の場所として最初の選択肢に入るのがGitHubです。蛇足ですが、Gitとよく混同されやすいので注意してください。

## GitHub CLI とは

[GitHub CLI](https://cli.github.com/) は、GitHubのコマンドラインツールです。GitHub CLIを使うと、GitHubのWeb UIを使わずに、ターミナル上でGitHubの操作が可能になります。

研究活動において利用する共用サーバの中には、ブラウザなどでログインすることが難しい場合があります。計算機ネットワークに慣れてくれば、SSH接続でも使う公開鍵認証でログインすることも可能ですが、GitHub CLIを使うと、直感的な操作でサーバからGitHubにログインすることができます。

## GitHub CLIのインストール

[GitHub CLI](https://cli.github.com/) のページに移動し、各自のOSに応じたインストール方法を確認してください。本記事の執筆時点での[Linux (Ubuntu/Debian系) でのインストール方法](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)は以下のとおりです。Ubuntu/Debian系のWSLなら、この方法でインストール出来るはずです。

```shell
# インストール
$ (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
 && sudo mkdir -p -m 755 /etc/apt/keyrings \
 && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
 && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
 && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
 && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
 && sudo apt update \
 && sudo apt install gh -y

# インストール後のソフトウェア更新
$ sudo apt update
$ sudo apt install gh
```

インストールできていれば、以下のコマンドでバージョンを確認できます。

```shell
$ gh --version
gh version 2.96.0 (2026-07-02)
https://github.com/cli/cli/releases/tag/v2.96.0
```

共用サーバなどでは、管理者権限がない (`sudo` が使えない) 場合が多いと思います。その場合は、例えば以下のようにインストールしてください。

1. [GitHub CLIのReleaseページ](https://github.com/cli/cli/releases/latest)から、利用したい計算機で使えるバイナリファイル (大抵は `GitHub CLI 2.96.0 linux amd64` など) をダウンロード (`wget` コマンドなどを使うと、サーバ上で直接ダウンロード可)
2. `tar` コマンドなどを使ってダウンロードしたファイルを展開し、`gh` コマンドを `$HOME/bin` などのディレクトリにコピー
3. `$HOME/bin` が `$PATH` に含まれていない場合は、`.bashrc` などに以下を追加

```shell
# $HOME/bin を PATH に追加
export PATH="$HOME/bin:$PATH"
```

## GitHub CLIでGitHubにログインする

GitHub CLIを使ってGitHubにログインするには、`gh auth login` を実行します。
コマンドが選択肢を確認してきますので、例えば以下のように選択します。

```shell
$ gh auth login
? Where do you use GitHub? GitHub.com
? What is your preferred protocol for Git operations on this host? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: 382D-34E5
Press Enter to open https://github.com/login/device in your browser... 
✓ Authentication complete.
- gh config set -h github.com git_protocol https
✓ Configured git protocol
! Authentication credentials saved in plain text
✓ Logged in as iijimahr
! You were already logged in to this account
```

途中、 `Press Enter to open https://github.com/login/device in your browser...` などで、ブラウザが自動で立ち上がると思います。
もしブラウザが立ち上がらない場合は、表示されるURL (上の例なら `https://github.com/login/device`) をコピーして手元のブラウザで開き、GitHubにログインしてください。
この際に利用するブラウザは、普段使っている手元のブラウザで構いません。あらかじめブラウザ上でGitHubにログインしておくとスムーズです。
ログイン後に表示される画面で、GitHub CLIの認証コード (上の例なら `382D-34E5`) を入力してください。

ログインできたか確認するには、次を実行します。

```shell
$ gh auth status
github.com
  ✓ Logged in to github.com account iijimahr (/home/iijimahr/.config/gh/hosts.yml)
  - Active account: true
  - Git operations protocol: https
  - Token: gho_************************************
  - Token scopes: 'gist', 'read:org', 'repo', 'workflow'
```

正常にログインできていれば、現在ログインしているGitHubアカウントの情報が表示されます。

## GitHub CLIの基本操作

### リポジトリを作成する

新しいリポジトリを作成するには、次のようにします。

```shell
$ gh repo create
```

対話形式でリポジトリ名、公開範囲、cloneするかどうかなどを選択できます。

作成後、自動でcloneされた場合は、次のようにリポジトリのディレクトリへ移動します。

```shell
cd github-cli-practice
```

### 既存のリポジトリをcloneする

すでにGitHub上にあるリポジトリをcloneするには、`gh repo clone` コマンドを使います。
例えば、<https://github.com/is-isee/training_course> をクローンするなら、以下のようになります。

```shell
gh repo clone is-isee/training_course
```

## よく使うGitHub CLIコマンド

| コマンド | 内容 |
| --- | --- |
| `gh auth login` | GitHubにログインする |
| `gh auth status` | ログイン状態を確認する |
| `gh repo create` | GitHub上に新しいリポジトリを作成する |
| `gh repo create 名前 --public --clone` | 公開リポジトリを作成し、同時にcloneする |
| `gh repo clone ユーザー名/リポジトリ名` | GitHub上のリポジトリをcloneする |
| `gh repo view --web` | 現在のリポジトリをブラウザで開く |

## 補足

GitHub CLIはログインやリポジトリ作成以外にも、Issue、Pull Request、GitHub Actionsなどをターミナルから操作できます。詳しくは公式マニュアルを参照してください。

GitHub CLI manual: <https://cli.github.com/manual/>

また、VSCodeにはGitHubの拡張機能があり、VSCode上でGUIを使ったGitHubの操作が可能です。興味があれば調べてみてください。

## 演習: GitHub CLIでプロジェクトをクローン・編集

1. GitHub CLIをインストールする
2. `gh auth login` でGitHubにログインする
3. `gh auth status` でログイン状態を確認する
4. 新しいリモートリポジトリを作成し、ローカルに`clone`する
5. ローカルでファイルを編集・追加
6. GitHub上のリモートリポジトリへ`push`
7. Web UIで`push`した内容が反映されていることを確認

なお手順4では、以下のどちらの方法を使っても構いません。

- 方法1: `gh repo create 名前 --public --clone` で作成と同時にclone
- 方法2: ブラウザでGitHubを開き、`gh repo clone` コマンドを使ってクローン
