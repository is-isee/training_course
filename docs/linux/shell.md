# シェルとターミナル

Linuxを操作する上で基本となるのが、**シェル**と**ターミナル**です。

- **シェル**: ユーザーから入力されたコマンドを解釈し、OSに指示を伝えて実行するプログラムです。コマンドラインでの作業効率を高める様々な機能も提供します。
- **ターミナル** (ターミナルエミュレータ): ユーザーがシェルに対してコマンドを入力したり、その結果を表示したりするための「ウィンドウ」や「インターフェース」です。

このコースでは、様々なシェルの中でも最も広く普及している `bash` を例に、多くのシェルで共通する機能を紹介します。これらはターミナル上でシェルを操作する際のものです。

## 様々なシェル

- `sh`（Bourne Shell）: POSIX 標準に準拠した最低限の機能を持つシェル
- `bash`（Bourne Again Shell）: Bourne Shell の GNU プロジェクト版
- `dash` (Debian Almquist Shell): ほぼ純粋な POSIX 準拠、軽量高速
- `zsh`: 高度な補完・カスタマイズ機能  
- `csh/tcsh`: C風の構文。現在はあまり主流ではない  

## シェルを終了する `exit` / `Ctrl-D`

- `exit`: シェルを終了 (`exit 1`のように終了ステータスを渡すことも可能)
- `Ctrl-D`: 標準入力の EOF シグナルを送信 (対話型シェルを終了)
- `reset`: ターミナルの表示が乱れた際に、表示を初期状態に戻す

## コマンドを中断する `Ctrl-C`

- 終了までに長い時間がかかるコマンドを中断する場合、`Ctrl-C`を押すと強制終了可能

## Tab によるコマンド補完

部分入力後に Tab を押すと、ファイル名／コマンド名を自動補完されます。
補完候補が複数ある場合は、再度 Tab を押すと一覧が表示されます。

```bash
$ cd Doc<Tab>   # Documents/ などに補完
```

## Ctrl-R による履歴閲覧

多くのシェルでは、インクリメンタルサーチで過去に利用したコマンドを呼び出すことができます。
TabとCtrl-Rを積極的に使い、できる限りタイピングの数を減らす習慣をつけましょう。

- `Ctrl-R` → 検索文字列入力 → 該当コマンドが表示  
- `Enter` で実行、`Ctrl-R` 再押下で次の候補  

```bash
(reverse-i-search)`ssh': ssh user@server.example.com
```

## カーソル移動のショートカット

| コマンド | 内容 |
| ---- | ---- |
| Ctrl + F | 1文字右へ移動 |
| Ctrl + B | 1文字左へ移動 |
| Ctrl + A | 行の先頭へ移動 |
| Ctrl + E | 行の最後へ移動 |
| Ctrl + P | 前の行へ移動 |
| Ctrl + N | 次の行へ移動 |
| Meta + F | 1単語右へ移動 |
| Meta + B | 1単語左へ移動 |

Metaキーは環境によって異なります。WindowsならAltキー、macOSならOptionキーが一般的です。
EscキーでMetaキーの代わりになる場合もあります。

## テキスト編集のショートカット

| コマンド | 内容 |
| ---- | ---- |
| Ctrl + H | カーソル左側の文字を削除 |
| Ctrl + D | カーソル位置の文字を削除 |
| Ctrl + W | カーソル位置の単語を削除 |
| Ctrl + U | カーソル位置から行頭まで削除 |
| Ctrl + K | カーソル位置から行末まで削除 |
| Ctrl + Y | 最後に削除した内容を挿入 |

## その他のショートカット

| コマンド | 内容 |
| ---- | ---- |
| Tab | コマンドの補間 |
| Ctrl + R | コマンドの履歴を呼び出し |
| Ctrl + C | 実行中のコマンドを停止 |
| Ctrl + Z | 実行中のコマンドを一時停止 |
| Ctrl + L | 画面の消去 (`clear`と同等) |
| Ctrl + D | 標準入力の EOF シグナルを送信 (対話型シェルを終了) |

## コマンドの呼び出し方

- コマンドの形式は `コマンド名 オプション 引数`
- 例: `ls -a ~/`
  - `ls`: コマンド名
  - `-a`: オプション(`--all`の別名)
  - `~/`: ホームディレクトリを示す引数
- 補足
  - オプションやファイル名は省略できる場合もある(コマンドによる)
  - ファイル名に空白や特殊文字が含まれる場合は引用符で囲む
    - 例: `ls "My Documents"`
  - オプションを複数指定する場合は並べる
    - 例: `ls -a -l -h` (`ls -alh` とまとめてもOK)
  - オプション自体が値をとる場合もある
    - 例: `grep -e pattern file.txt`

## シェル変数と環境変数

- **シェル変数**
  - `VAR=value` で定義
  - 定義したシェル内のみ有効
- **環境変数**
  - `export VAR` で定義
  - 子プロセスにも継承
  - 一覧表示: `env` または `printenv`

```bash
$ MYVAR=hello
$ echo $MYVAR
hello
$ bash -c 'echo $MYVAR'   # シェル変数は子プロセスで参照不能
                          # 何も出力されない
$ export MYVAR            # シェル変数を環境変数に
$ bash -c 'echo $MYVAR'   # 環境変数は子プロセスでも参照可能
hello
```

## 環境変数 PATH

シェルはコマンドを探す際に環境変数 `PATH` に記述されたディレクトリを探索していきます。もし `command not found` のようなエラーが出る場合、`PATH`が適切に指定されていない可能性があります。

- `PATH`: コロン区切りのディレクトリリスト  
- シェルは左から順に実行ファイルを検索  
- 動作確認: `which <cmd>` / `which -a <cmd>` / `type <cmd>`  

```bash
$ echo $PATH
/usr/local/bin:/usr/bin:/bin:...

$ which python  # python と指定した時に呼び出される実行ファイルを表示
/usr/bin/python

$ which -a python  # PATHに含まれる全ての実行ファイルを表示
/usr/bin/python
/usr/local/bin/python
```

## コマンドに別名をつける alias

- `alias name='command -options'` で短縮形を作成  
- `unalias name` で削除  

```bash
$ alias ll='ls -lah'
$ type ll
ll is aliased to `ls -lah`

$ ll
drwxr-xr-x 5 user user 4.0K Apr  7 10:00 .
```

## シェルの設定 `~/.bashrc`、`~/.bash_profile`

- `~/.bash_profile`（または `~/.profile`）  
  - **ログインシェル** 起動時に読み込まれる  
  - リモート SSH ログインやコンソールログイン時に適用  
- `~/.bashrc`  
  - **インタラクティブ非ログインシェル** 起動時に読み込まれる  
  - ターミナルエミュレータ（例: GNOME Terminal）や `bash` コマンド実行時に適用  

共通設定を両方で使いたい場合は、`~/.bash_profile` から `~/.bashrc` を呼び出すようにします。

```bash
# ~/.bash_profile
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
```  

`~/.bashrc` に書く典型例。

```bash
# ~/.bashrc

# プロンプト設定
export PS1="\u@\h:\w\$ "

# エイリアス
alias ll='ls -lah'
alias gs='git status'

# 環境変数追加
export PATH="$HOME/bin:$PATH"

# エディタ設定
export EDITOR=vim
```  

- **反映方法**  
  - 編集後、既存ターミナルに反映するには `source ~/.bashrc` を実行
  - 新しいターミナルを開けば自動適用
- **注意点**  
  - シェルごとに設定ファイルの名前・読み込み順序が異なる（例: zsh は `~/.zshrc`）  
  - 不要な設定や無限ループを作らないように、条件分岐や存在チェックを行うこと
