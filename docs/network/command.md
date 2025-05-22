# 便利なネットワークコマンド

ここでは、ネットワークの状態を確認したり、ネットワーク越しにファイルを操作したりする際に役立つ基本的なコマンドを紹介します。これらのコマンドは、ターミナル（Macならターミナル.app、WindowsならWSLやGit Bashなど）で実行します。

## 装置のネットワーク接続情報を調べる: `ip` (`ifconfig`)

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

## ホストからの応答を調べる: `ping`

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

## ドメイン名からIPアドレスを調べる: `host`

ドメイン名に対応するIPアドレスをDNSに問い合わせて表示します。

```bash
$ host scplatform2021.isee.nagoya-u.ac.jp
scplatform2021.isee.nagoya-u.ac.jp has address 133.47.151.54
```

## ネットワークごしにデータをコピーする: `scp` と `rsync`

- `scp`: ファイルをSSH経由でコピー

```bash
$ scp localfile.txt user@remote:/path/to/destination/
$ scp -r localdir/ user@remote:/path/to/destination/
```

- `rsync`: 差分のみを転送する効率的な同期ツール(バックアップに便利)

```bash
$ rsync -avz localdir/ user@remote:/path/to/destination/
```

## ネットワーク上の情報を取得する: `wget` と `curl`

Webサイト(HTTP/HTTPS)上にあるファイルや情報をダウンロードできます。スクリプトでの自動ダウンロードなどにも便利です。

- `wget`: Web上のファイルをダウンロードするシンプルなコマンド

```shell
# 指定したURLのファイルをダウンロードして保存
$ wget https://is-isee.github.io/training_course/index.html
```

- `curl`: 多機能なデータ転送ツール

```shell
# 指定したURLのファイルをダウンロードして保存 (-O オプション)
$ curl -O https://is-isee.github.io/training_course/index.html

# Web APIから情報を取得して表示 (例: 天気予報)
$ curl wttr.in/Nagoya
```

## ネットワークごしにコマンドを実行する: `ssh user@remote <cmd>`

```bash
client$ ssh user@remote ls -l /tmp
```
