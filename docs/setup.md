# 事前準備

トレーニングコースの実習ではLinuxやCIDASシステムを使います。
実習前に各自で以下の準備を終えるようにしてください。

## ターミナル環境・SSHクライアントの準備

### Windowsの場合

WSL2 (Windows SUbsystem for Linux 2) を使うとWindows上でLinuxを利用できます。公式情報は <https://learn.microsoft.com/ja-jp/windows/wsl/install> にあります。

まず PowerShell またはコマンドプロンプトから以下のコマンドを実行し、画面に表示される指示に従う (おそらく再起動が必要になる)。

```powershell
PS C:\Users\<username>> wsl --install
```

スタートメニューに Ubuntu がアプリとして追加されるはずです。
Ubuntu を実行し、ユーザーとパスワードの設定を行ってください。

### macOSの場合

BSD UNIXがベースなのでもともとインストールされている `ターミナル.app` を使うことができます。

## CIDASシステムについて

![CIDASシステム](https://cidas.isee.nagoya-u.ac.jp/kyodo/_img/cidas_system2021_long.png)

[CIDASシステム](https://cidas.isee.nagoya-u.ac.jp/kyodo/cidas.shtml)はISEEが所有するデータ解析や数値計算を実行できるクラスタ計算機です。

- **システム構成:**
  - 1ノードのスペック
    - CPU : Xeon Gold 6230R (Cascade Lake, 2.1 GHz, 26 cores, 35.75 MB Cache) x 2
    - Memory : 384 GiB (32 GiB DDR4-2933 x 12)
  - 計算ノード14機、IDLノード2機、共用ストレージ(Lustreファイルシステム)
  - すべてのノードからアクセス可能なディスク領域 `/cidashome/sc/cNNNNxxxx` が500GBまで利用可能

## CIDASシステムへの登録

事前にCIDASシステムへの登録を完了してください。実習の一部はCIDASシステム上で行います。

- CIDASシステム登録ページ： <https://cidas.isee.nagoya-u.ac.jp/kyodo/regist.shtml.ja>
- CIDASシステム利用マニュアル：
  - 日本語: <https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:ja:manual:cidas:start>
  - 英語: <https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:en:manual:cidas:start>

申請の際にSSH公開鍵を自分のPCで作成して、申請ページに入力する必要があります。
CIDASシステム利用マニュアルの「1. 利用申請」および以下の説明を良く読んで実施してください。
不明点がありましたら、周りの先輩や研究員、教員に聞いてください。

## CIDASシステムへのSSH接続

以下は[CIDASシステム利用マニュアル](https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:ja:manual:cidas:start)を良く読みながら実施してください。

セキュリティ上の理由で、CIDASシステム (`scplatform2021` や `scfront2021`) のホームディレクトリには公開鍵を置くことは禁止されています。多段SSHのため、「SSHエージェント転送」という方法で接続します。以下は簡単な流れです。

### 0. `ssh-agent`の開始

```shell
client$ eval `ssh-agent`
client$ ssh-add <Registered private key>

# 成功した場合
client$ ssh-add -l
256 SHA256:~~~~~~~~~~ your_name@your_client (your key version)

# 失敗した場合
client$ ssh-add -l
Could not open a connection to your authentication agent.
If failed, please check your commands again.
```

### 1. `scplatform2021`へのログインとエージェント転送が成功しているかの確認

```shell
client$ ssh -A <Username>@scplatform2021.isee.nagoya-u.ac.jp

# エージェント転送が成功している場合
scplatform2021$ ssh-add -l
256 SHA256:~~~~~~~~~~ your_name@your_client (your key version)

# エージェント転送に失敗した場合
scplatform2021$ ssh-add -l
Could not open a connection to your authentication agent.
If failed, please check your commands again.
```

### 2. `scplatform`から`scfront2021`へのログイン

```shell
scplatform2021$ ssh <Username>@scfront2021
```

### SSHエージェントを自動で起動・停止するログインスクリプト `client:$HOME/.bashrc` (Windows/WSL2の場合)

macOSの場合は`ssh-agent`とKeychainの連携が組み込まれているため、以下の設定は不要です。

```shell
if [ -z "$(pgrep ssh-agent)" ]; then
    eval "$(ssh-agent -s)"
    trap 'kill $SSH_AGENT_PID' EXIT
fi
```

### ログインを簡単にするための設定 `client:$HOME/.ssh/config`

各自のPC上のホームディレクトリに `client:$HOME/.ssh/config` というファイルを作成し、以下の内容を書き込んでください。`scfront`のIPアドレス・ポート番号は周囲に聞くか実習時に質問してください。

```config
Host scplatform
 Hostname scplatform.isee.nagoya-u.ac.jp
 User <Username>
 ForwardAgent yes
 IdentityFile <Registered private key>

Host scfront
 HostName <IP of scfront2021 (NAPT)>
 Port <Port of scfront2021 in NAPT>
 User <Username>
 ProxyJump scplatform
 IdentityFile <Registered private key>
```

うまく設定されていれば、`scplatform`を経由することなく直接 `scfront` へログインできる。

```shell
client$ ssh scfront
```

### 複数のPCからCIDASシステムへログインしたい場合

もし複数のクライアントPCからログインしたい場合は、 `scplatform2021:$HOME/.ssh/authorized_keys` および `scfront2021:$HOME/.ssh/authorized_keys` に公開鍵を追加してください (既に登録されている鍵を消すとログインできなくなります)。その際も、登録する鍵はCIDASシステムが要求する暗号化方式に限ってください。執筆時点 (2025-04-04) では以下が許可されています。

- ECDSA公開鍵暗号化方式(鍵長 256 bits, 384 bits もしくは 521 bits)
- Ed25519公開鍵暗号化方式
