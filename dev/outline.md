# 演習内容のアウトライン

## 計算機関係の基礎知識

- CIDASシステムの紹介
  - (SSH、公開鍵、設定方法)
  - (CIDASシステムへのログイン方法)
- Linuxにおけるファイルシステムの考え方
- ターミナルとシェル
  - タブによる補間
  - `ctrl-R` による履歴閲覧
- ファイル・ディレクトリの操作
  - ネットワークごしのコピー `scp`
  - ファイル・ディレクトリのバックアップ `rsync`
- コマンドの使い方がわからない時に `man`, `<command> --help`
- テキストファイルとバイナリファイル (文字列の表現)
- 標準出力・標準入力・標準エラー出力
  - 標準出力へ書き込み `echo`
    - ファイルの実態
  - パイプとリダイレクト
  - **演習**: 回文の表示 (`rev`)
- ファイル・ディレクトリの権限
- ファイル情報の取得: `cat, less, head, tail, grep`
- **演習**: シンボリックリンクを作ってみる
- システム情報の取得
  - Linuxにおけるプロセスの考え方
  - プロセスの操作 `ps`、`kill`
  - 待機コマンド `sleep`
  - **演習**: プロセスの生成と削除
  - システム情報の取得 `w`、`last`、`top`
  - 共有サーバ利用の心得
  - **演習**: `write` で他のユーザーとお喋り (`mesg`の確認)
- ネットワーク
  - ネットワークの階層構造
  - IP/TCP
  - ISEE内部のネットワーク (資料非公開)
- ネットワーク上の情報の取得
  - `wget` と `curl`
  - **演習**: 天気予報を表示する `curl wttr.in`

## 研究に便利なツール (その1)

- バージョン管理 Git/GitHub
  - バージョン管理の必要性
  - Git 入門: リポジトリ、コミット、ブランチ
  - GitHub CLI
  - **演習**: リポジトリの作成、コミット、ブランチの作成・削除、イシューの作成、プルリクエスト
- Jupyter ノートブック・ラボ
- テキストエディタ VSCode
  - ワークスペースの考え方
  - リモートサーバへの接続
    - 共用サーバへ接続する際の注意点: `git`を積極的に使う

## データの解析と可視化

- Python入門
  - **演習**: コードのリファクタリング (関数・クラスの活用)
- NumPy 入門
  - 演習: 数式からプログラムへの変換
- Matplotlib 入門
  - **演習**: 線グラフの描画
  - **演習**: 画像の描画
- 平均、分散、相関
  - **演習**: モンテカル法
- 離散フーリエ変換
  - **演習**: ダイナミックスペクトル

## 研究に便利なツール (その2)

- 動画の作成
  - ファイル形式 GIF
  - FFmpeg 入門
  - **演習**: GIF / MP4 動画の作成
- シェルスクリプト
  - バッチ処理
  - ジョブ管理システム
  - **演習**: CIDASシステムへのジョブ投入
- タスクランナー Makefile
  - **演習**: データ処理から画像作成までの自動化

## 数値シミュレーション

- 数値計算と誤差
- 常微分方程式
  - Runge-Kutta法
  - Buneman-Boris法
  - **演習**: 荷電粒子の運動とエネルギー保存
- 偏微分方程式
  - 中央差分法
  - CFL条件
  - Odd-even デカップリング
  - **演習**: スカラー移流拡散方程式とスカラー保存
- 行列計算
  - 固有値と固有ベクトルの復習
  - 条件数と反復回数
  - 行列計算の誤差
  - **演習**: 電離反応方程式と安定性
  - 密行列と疎行列
  - Jacobi法とCFL条件
  - **演習**: ポアソン方程式

## 研究に便利なツール (その3)

- マークアップ言語 Markdown
- LaTeX と Overleaf
- 文献管理ツール Zotero, Google Scholar
- タスク・プロジェクト管理ツール
- シンボリック計算
