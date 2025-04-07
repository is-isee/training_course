# ネットワーク入門

ネットワークは複数の階層（レイヤ）で構成されており、それぞれが異なる役割を担っている。代表的なネットワークのモデルにはOSI参照モデルが挙げられる。本トレーニングコースでは、ネットワーク接続などで必要となるIPおよびTCP/UDP over IPの基礎知識に集中して紹介する。

## IP通信

- **IP（Internet Protocol）**: 機器を一意に識別するアドレス（例: 192.0.2.1）
- IPアドレスとMACアドレス、ARP
- ネットマスク、ネットワーク部とホスト部
- 同じネットワーク部を持つホスト同士は直接通信できる
- デフォルトゲートウェイ
- ブロードキャスト
- ループに注意
- `ping`の使い方

## TCP/UDP over IP (TCP/IP)

- **TCP（Transmission Control Protocol）**: データを順序通りに確実に届ける仕組み
- ポート番号
  - 例: sshの場合
  - 例: httpの場合
- napt
- ドメイン名とdnsサーバー

## コマンド

- `ip a`: IPアドレス・MACアドレス・ネットワーク設定・接続状況などの確認
- `ip r`: デフォルトゲートウェイなどの確認
- `ss -a` (`ss -a | grep ssh` など): 全ポートの通信状況
- `dig <domain_name>`: DNSサーバへの問い合わせ

## 補足: `net-tools`と`iproute2`

- `net-tools`: `ifconfig`など。古い
- `iproute2`: `ip, ss`など。最近はこちらが主流

## ドメイン名とIPアドレスの対応関係

- **ドメイン名**: IPアドレスに対応付けられた名称 (例: `www.example.com` など)
- **DNSサーバ**:
- `dig`の使い方

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

HTTP経由でデータを取得

```bash
$ wget https://is-isee.github.io/training_course/index.html
$ curl -O https://is-isee.github.io/training_course/index.html
```

天気予報の表示(遊び)

```bash
$ curl wttr.in
```

文字ベースで現在地の天気が表示される。

## ネットワークごしのコマンド実行 `ssh user@remote <cmd>`

```bash
client$ ssh user@remote ls
```

## ISEE内部のネットワーク

ISEE内部のネットワークに関する情報は、内部向け資料を参照すること。
本トレーニングコースでは詳細は議論しない。
