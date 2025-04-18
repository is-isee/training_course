# ネットワーク入門

ネットワークは複数の階層（レイヤ）で構成されており、それぞれが異なる役割を担っています。代表的なネットワークのモデルにはOSI参照モデルやTCP/IP参照モデルがあります。本トレーニングコースでは、ネットワークの接続設定などで必要となるIP通信の基礎知識を中心に紹介します。

## IP通信

IP（Internet Protocol）通信では、そのプロトコルに基づいてコンピュータ同士でデータをやり取りします。このプロトコルには、データの送信元や宛先を指定するルールが記載されており、インターネットを始め多くのネットワークで利用されています。ここではその基礎事項を紹介します。

### IPアドレスとMACアドレス

- **IPアドレス** (例: `192.0.2.1`):
  - ネットワーク上で各機器を一意に識別するための番号
  - 接続するネットワークごとに変わる
  - IPv4(後述)では32ビット
- **MACアドレス** (例: `00:aa:11:bb:44:cc`):
  - 各機器に割り当てられた固有の番号
  - 基本的には接続するネットワークによらず変わらない

### ネットマスクとネットワーク部／ホスト部

- **ネットマスク** (例: `/24` = `255.255.255.0`):
  - IPアドレスのネットワーク部とホスト部を区別する数値(マスク)
- **ネットワーク部** (例: `192.0.2.0`):
  - IPアドレスの2進数表現における前半
  - そのIPアドレスが属するネットワークの識別番号
- **ホスト部** (例: `0.0.0.1`):
  - IPアドレスの2進数表現における後半
  - そのネットワーク内における機器(ホスト)の識別番号

上の例ではネットワーク部が24桁、ホスト部が8桁で、同じネットワーク内には $2^8=256$ 個の機器を識別できます。**同じネットワーク部を持つホスト同士は直接通信することができます**。

### ルーターの役割

同じネットワーク部を持つホスト同士は直接通信できますが、異なるネットワーク部を持つホスト同士は直接通信することができません。そこで、ルーターが異なるネットワーク間を中継(または転送)することで、通信が可能になります。ルーターは異なるネットワークに属するホスト間の通信を可能にする中継装置として機能します。

### デフォルトゲートウェイ

デフォルトゲートウェイとは、ネットワーク内から外部に接続するための機器(例: ルーター)のことです。各ネットワーク機器は、IP通信を行う際に宛先のネットワーク部を確認し、宛先がネットワーク内であれば直接送信し、宛先がネットワークの外部であればデフォルトゲートウェイにデータを転送します。そのため、各ホストはネットワークのデフォルトゲートウェイのアドレスを知っている必要があります。

### ネットワークのループに注意

LANケーブルの接続ミスやネットワーク機器の配線ミスが原因で、ネットワークにループが発生する場合があります。このとき、ネットワークに送信されたパケットは正しい宛先を探すことができずに永久に転送され続けるため、正常な通信が妨害される場合があります。そのため、ネットワークの配線を行うときには細心の注意を払ってください。

### ネットワークの接続設定を簡単に行う仕組み DHCP

普段WiFiなどでIPアドレスやネットマスクなどを入力しないのに、ISEEで有線LANを利用する場合には必要になることを不思議に思うかもしれません。これは、WiFiルータ等がDHCP (Dynamic Host Configuration Protocol)というプロトコルに則って、ネットワークに接続する機器にIPアドレス等を自動で割り振っているためです。

### IPアドレス枯渇問題とIPv6

本項で説明したのは従来から存在するIPv4と呼ばれるプロトコルで、32ビットのIPアドレスで各装置を識別します。IPv4で使用可能なアドレスは約40億($2^{32}$)個で、インターネット上に接続する装置を全てカバーするのには不足です。そのため、ローカルのネットワークにおけるIPアドレスとグローバルなネットワーク(インターネット)におけるIPアドレスを使い分けるなどにより対応してきました。

IPv6は現在も普及が進むIPv4に続く次世代の通信規格で、IPアドレスは128ビットです。IPv6により、IoT (Internet of Things)のようにあらゆるモノ(Things)がインターネットに接続される状況であっても、各ホストを一意に区別することが可能になると期待されています。

## 装置のネットワーク接続情報を調べる `ip` (`ifconfig`)

`ip`コマンドを使うと現在のネットワークへの接続設定や接続状況を確認することができます。OSによっては`ifconfig`が同等の機能を持ちます。`ip`と`ifconfig`は異なるネットワークツール群(それぞれ`iproute2`、`net-tools`)に属すコマンドで、より新しい`iproute2`への移行が徐々に進んでいます。

```bash
# IPアドレス/ネットマスク: 1.2.3.4/24
# MACアドレス: 1a:2b:3c:4e:5f:60
$ ip a  # ip address でも良い
# 中略
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 1a:2b:3c:4e:5f:60 brd ff:ff:ff:ff:ff:ff
    inet 1.2.3.4/24 brd 1.2.3.255 scope global eth0       # 左側がIPアドレス/マスク
       valid_lft forever preferred_lft forever
# 後略

# デフォルトゲートウェイ: 1.2.3.1
$ ip r  # ip route でも良い
default via 1.2.3.1 dev eth0 proto static 
1.2.3.0/24 dev eth0 proto kernel scope link src 1.2.3.4
```

## ホストからの応答を調べる `ping`

`ping`コマンドを使うと特定のIPアドレスを持つ機器から応答があるかを調べることができます。
ネットワークの接続試験などに利用できます。

```bash
$ ping 8.8.8.8   # Google Public DNS
ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=116 time=4.09 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=116 time=3.90 ms
# 終了はCtrl-C
```

## TCP/IP (TCP over IP)

IP通信と**TCP（Transmission Control Protocol）**を組み合わせたTCP/IPはデータを順序通りに確実に届ける非常に一般的なプロトコルです。インターネット・プロトコル・スイートとも呼ばれています。我々がよく利用するSSH、HTTP、SMTPなどのプロトコルも、このTCP/IPの上に構築されています(SSH over TCP over IPなど)。

### ポート番号

TCP/IP通信ではIPアドレスに加えて、通信に使用するプログラムを識別するための番号であるポート番号が利用されます。いくつかのポート番号は特定の通信プロトコルで利用することが決められています。以下はその例です。

| プロトコル | ポート番号 |
| -------- | --------- |
| SSH      | 22        |
| HTTP     | 80        |
| HTTPS    | 443       |

### IPマスカレード(NAPT)

IPマスカレード(NAPT; Network Address Port Translation)とは、1つのIPアドレスを複数の装置で共有する機能の一つです。IPアドレスとポート番号を組み合わせることで、同じIPアドレスに対する通信でも異なる装置にアクセスすることができます。IPアドレス枯渇問題で、ローカルネットワークとグローバルネットワークのアドレスを分離する話がありましたが、これもNAPTを使って実現することができます。

## ドメイン名とIPアドレスの対応関係 `dig`

我々がネットワークを利用する際、多くの場合はIPアドレスを直接指定せず、IPアドレスに紐づけられた**ドメイン名**(例: `google.com`)を利用します。例えば、ドメイン名`scplatform2021.isee.nagoya-u.ac.jp`はグローバルなIPアドレス`133.47.151.54`に紐づけられています。これを確認するには `dig` コマンドを利用できます。

```bash
$ dig scplatform2021.isee.nagoya-u.ac.jp
# 前略
;; ANSWER SECTION:
scplatform2021.isee.nagoya-u.ac.jp. 21600 IN A  133.47.151.54
# 後略
```

## ネットワークごしのデータコピー `scp`、`rsync`

`scp`: ファイルをSSH経由でコピー

```bash
$ scp localfile.txt user@remote:/path/to/destination/
$ scp -r localdir/ user@remote:/path/to/destination/
```

`rsync`: 差分のみを転送する効率的な同期ツール(バックアップに便利)

```bash
rsync -avz localdir/ user@remote:/path/to/destination/
```

## ネットワーク上の情報の取得 `wget`、`curl`

`wget`や`curl`を使うとHTTP経由でデータを取得することができます。ウェブサイト上にアップロードされているようなデータを取得する場合、これらのコマンドを使って自動でダウンロードするスクリプトを作ることができます。

```bash
# https://is-isee.github.io/training_course/index.html をダウンロードし、
# ./index.htmlとして保存
$ wget https://is-isee.github.io/training_course/index.html
$ curl -O https://is-isee.github.io/training_course/index.html

# 天気予報の表示
$ curl wttr.in
```

## ネットワークごしのコマンド実行 `ssh user@remote <cmd>`

```bash
client$ ssh user@remote ls
```

## ISEE内部のネットワーク

ISEE内部のネットワークに関する情報は、内部向け資料を参照してください。
