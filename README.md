# ISEE総合解析研究部トレーニングコース

## 目的

名大ISEE総合解析研究部に所属する学生が、研究遂行にあたって必要な基礎知識を身につけるための演習。

## 事前準備: CIDASシステムへの登録

CIDASシステムへの登録を進めてください。実習は、基本的にCIDASシステム上で行います。  

- CIDASシステム登録ページ： <https://cidas-local.isee.nagoya-u.ac.jp/acc/regist.html>
- CIDASシステム利用マニュアル：
  - ja: <https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:ja:manual:cidas:start>
  - en: <https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:en:manual:cidas:start>

申請に際して、SSH公開鍵を自分のPCで作成して、申請ページに入力する必要があります。  
[利用マニュアル](https://chs.isee.nagoya-u.ac.jp/scwiki/doku.php?id=public:ja:manual:cidas:start)の「1. 利用申請」を良く読んで実施してください。  
不明点がありましたら、先輩、PD、教員に聞いてください。

## 扱う内容の候補

- 計算機とその周辺の基礎知識
  - (SSH、公開鍵、設定方法)
  - CIDASシステムの紹介
  - Linuxにおけるファイルシステムの考え方
  - ファイル・ディレクトリの操作
    - テキストファイルとバイナリファイル (文字列の表現)
  - ファイル・ディレクトリの権限
  - ファイル情報の取得
  - システム情報の取得
    - 共有サーバ利用の心得
  - ネットワーク
    - ネットワークの階層構造
    - IP/TCP
    - ISEE内部のネットワーク (資料非公開)
- 便利なツール (その1)
  - Jupyter ノートブック・ラボ
  - テキストエディタ VSCode
    - ワークスペースの考え方
    - 共用サーバへ接続する際の注意点
  - バージョン管理 Git/GitHub
    - **演習**: リポジトリの作成、コミット、ブランチの作成・削除、イシューの作成、プルリクエスト
- データの解析と可視化
  - Python入門
  - **演習**: コードのリファクタリング (関数・クラスの活用)
  - NumPy 入門
  - 演習: 数式からプログラムへの変換
  - Matplotlib 入門
  - **演習**: 線グラフの描画
  - **演習**: 画像の描画
  - 離散フーリエ変換
  - **演習**: ダイナミックスペクトル
- 便利なツール (その2)
  - 動画の作成
    - ファイル形式 GIF
    - FFmpeg 入門
    - **演習**: GIF / MP4 動画の作成
  - シェルスクリプト
    - バッチ処理
    - ジョブ管理システム
    - **演習**: CIDASシステムにジョブを投げる
  - タスクランナー Makefile
    - **演習**: データ処理から画像作成までの自動化
- 数値シミュレーション
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
- 便利なツール (その3)
  - マークアップ言語 Markdown
  - LaTeX と Overleaf
  - 文献管理ツール Zotero, Google Scholar
  - タスク・プロジェクト管理ツール

## 参考文献

### UNIX/Linux

- [「Linux 標準教科書」LinuC](https://linuc.org/textbooks/linux/) (PDF版無料)
- [明治大学生田メディア支援事務室 UNIXの手引き](https://www.meiji.ac.jp/isys/doc/UNIX2019.pdf) (PDF)
- [「新しいLinuxの教科書」三宅 英明、大角 祐介](https://www.sbcr.jp/product/4797380941/) (書籍)

### VSCode

- [Getting Started with Visual Studio Code](https://code.visualstudio.com/docs/introvideos/basics)

### Python

- [Python公式チュートリアル](https://docs.python.org/ja/3/tutorial/)
- [NumPyの学び方](https://numpy.org/ja/learn/) (動画資料あり)
- [NumPyユーザーガイド](https://numpy.org/doc/stable/user/index.html)
- [Matplotlibチュートリアル](https://matplotlib.org/stable/tutorials/index.html)
- [nkmk note](https://note.nkmk.me/) (Python以外もあり)
- [東大天野さんの Python 演習資料](https://amanotk.github.io/python-resume-public/)

### IDL

- [L3 Harris IDL入門](https://nv5geospatialsoftware.co.jp/Portals/74/VIS_JAPAN/documents/IDL88_training.pdf) (PDF)
- [Getting Started with IDL](https://www.nv5geospatialsoftware.com/docs/Getting_Started.html)

### 太陽地球圏特有のライブラリ・ツール

- [あらせサイエンスセンター「解析ツール、データの使い方」](https://ergsc.isee.nagoya-u.ac.jp/data_info/howto.shtml.ja) (pySPEDAS / SPEDAS / UDAS)
- [SunPy](https://sunpy.org/)
- [SolarSoftWare (SSWidl)](https://www.lmsal.com/solarsoft/)
- [ChiantiPy](https://chiantipy.readthedocs.io/en/latest/)
- [Chianti Atomic Database](http://chiantidatabase.org/)

### Fortran

- [東大天野さんの Fortran 演習資料](https://amanotk.github.io/fortran-resume-public/)

### C++

- [C++日本語リファレンス](https://cpprefjp.github.io/)

### 数値計算

- [東大「地球物理数値解析」講義資料](https://github.com/amanotk/numerical-geophysics)
- [「数値計算の常識」伊理 正夫・藤野 和建](https://www.kyoritsu-pub.co.jp/bookdetail/9784320013438) (書籍)
