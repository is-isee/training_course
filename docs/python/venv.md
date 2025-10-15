# Python の仮想環境

Google Colab では、あらかじめ多くのライブラリがインストールされている。
実際に研究や開発で Python を利用する際には、様々な外部のライブラリをインストールして利用することになる。

Python で外部のパッケージをインストールする場合、パッケージ間の依存性に伴うトラブル (dependency hell) が発生することがある。
これはパッケージの総数が増えたり、インストール時期が大きく異なったり、機械学習など更新頻度が高くシステム依存性の強いパッケージを導入する際に起きやすい。

依存地獄を回避する1つの方法が Python が標準で用意している[仮想環境の作成機能 `venv`](https://docs.python.org/ja/3/library/venv.html)を利用することである。

## 仮想環境の作成と利用

プロジェクトディレクトリに1つの `venv` ディレクトリを用意すると、VSCode との相性が良い。
以下は Linux / macOS 上での例である。

```shell
# プロジェクトディレクトリに移動
cd my_project

# 仮想環境の作成 (./.venv/ という隠しディレクトリが出来る)
python3 -m venv .venv

# 仮想環境の有効化
. .venv/bin/activate

# 仮想環境の確認
which python3
# ./venv/bin/python3 が表示されるはず

# 仮想環境の無効化
deactivate
```

仮想環境のディレクトリ名は好きに指定出来る (`python3 -m venv my_new_venv` など) が、慣例的に `.venv` や `venv` とすることが多い。
ディレクトリ `.venv/` の中には Python インタープリタや標準ライブラリ、`pip` コマンドなどがコピーされる。
もしプロジェクトをGitで管理する場合は、`.gitignore` に `.venv/` などを追加すること。

## 仮想環境内でのパッケージのインストール

仮想環境を有効化した状態で `pip` コマンドを利用することで、仮想環境内にパッケージをインストールできる。

```shell
# 仮想環境の有効化
. venv/bin/activate

# pip 自体のアップグレード
pip3 install -U pip

# パッケージのインストール
pip3 install matplotlib pandas

# パッケージのインストール (requirements.txt から)
pip3 install -r requirements.txt
```

ここで、`requirements.txt` は以下のような形式のテキストファイルである。
インストールしたファイルを記録しておけるため、プロジェクトの再現性が向上する。

```txt
# # から始まる行はコメントとして認識される

# インストールしたいパッケージを1行に1つずつ書く
# 上から順にインストールされていく
matplotlib
ipykernel

# バージョン指定する場合は以下のように書く
numpy>=2.0
```

## VSCode との連携

作成した仮想環境を VSCode で利用するには、コマンドパレットを開き、 `Python: Select Interpreter` を選択し、作成した仮想環境を選択する。
Jupyter Notebook で利用する場合も同様にコマンドパレットから `Python: Select Interpreter to start Server` などを選択し、仮想環境を選択すれば良い。
それぞれGUIもあるため、そちらを利用しても良い。

プロジェクトディレクトリに存在する VSCode の設定ファイル `my_project/.vscode/settings.json` に以下のように書き込むこともできる。

```json
{
    "python.pythonPath": "venv/bin/python",
    "python.defaultInterpreterPath": "venv/bin/python"
}
```

## 非標準の方法

Python が標準で用意している `venv` や `pip` 以外にも、開発環境を管理するための様々なツールが存在する。以下にその一部を示す。

- [pyenv](https://github.com/pyenv/pyenv): Python インタープリタの管理ツール。
- [uv](https://docs.astral.sh/uv/): パッケージ・インタープリタの管理ツール。Rust 製高速。
- [Miniforge](https://conda-forge.org/): パッケージ・インタープリタ・システムライブラリの管理ツール。
  - 有償になってしまった Anaconda / Miniconda の代替として推奨
- [Docker](https://www.docker.com/): コンテナ型仮想化。Python だけでなく、OS 層まで含めた環境の分離が可能。

## 練習

以下の課題には、ローカル管理が必要である。

1. 新しいプロジェクトディレクトリを作成し、`venv` を利用して仮想環境を作成せよ。
2. `requirements.txt` を利用して `numpy` と `matplotlib` をインストールせよ。
3. 仮想環境を有効化し、Python インタープリタを起動し、`numpy` と `matplotlib` が利用できることを確認せよ。
