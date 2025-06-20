# Python入門

本記事は執筆中です。

## 環境設定

-- 執筆中 --

## 基礎文法

Pythonのチュートリアルは世界中いたるところに存在します。ひとまず[Python公式チュートリアル](https://docs.python.org/ja/3/tutorial/)を参照してください。

- 全くPythonを学んだことがない人: 2-7章
- Pythonを使って効率的に研究したい人: 9章(クラス)、10章・11章(標準ライブラリ)
- 深層学習など多くのライブラリに依存する人: 12章(仮想環境とパッケージ)

## NumPy

[NumPy](https://numpy.org/)は特に配列や浮動小数点を使った科学技術計算をする場合に基礎となるライブラリです。後述のMatplotlibもNumPyに依存しています。

NumPyも[非常に多くの学習用資料](https://numpy.org/ja/learn/)が存在しています。
ひとまずNumPy公式ドキュメントの[NumPy quickstart](https://numpy.org/doc/stable/user/quickstart.html)および[NumPy: the absolute basics for beginners](https://numpy.org/doc/stable/user/absolute_beginners.html)を読んでください。
様々なクラスや関数が定義されていますが、ここで出たもの以外は徐々に覚えていきましょう。

## Matplotlib

[Matplotlib](https://matplotlib.org/)はNumPyと密接に連携した可視化ツールです。
非常に多くのことが出来るので、特に3次元可視化以外はこれで済むことが多いでしょう。
ひとまず[Matplotlib公式チュートリアル](https://matplotlib.org/stable/tutorials/index.html)の"Quick start guide"、"Customizing Matplotlib with style sheets and rcParams"、"Animations using Matplotlib"だけ読んでしまいましょう。

## Pythonは「遅い」

Pythonは**インタープリタ型言語**です。

C言語やFortranなどの**コンパイル型言語**では、ユーザが記述したプログラムをコンパイラが計算機の理解出来る機械語に翻訳し、実行します。十分に賢いコンパイラであれば高速な実行が期待出来ます。

インタープリタ型言語では、プログラムと計算機の間を翻訳者・通訳としての**インタープリタ**が仲介します。ユーザが記述したプログラムの各行を位置行づつ確認し、インタープリタ内の関数やAPIとして解釈し、計算機に仕事を依頼します。そのため、その実行速度は多くの場合、コンパイル型言語の10-100倍以下になります。

じゃあなぜPythonを使うのかといえば、プログラムを1行づつ実行出来るので、実行結果を確認しながらプログラムを書けるのが理由の一つです。
また、大量のユーザを抱えているためにライブラリが発達しており、ユーザの記述量が少なくて済むからというのも大きい理由です。

Pythonで書いたプログラムを高速化する場合、十分に高速化されたライブラリのAPIを利用する、というのが基本方針です。例えば、配列の総和を計算する場合、ユーザが `for` 文を書いて総和を求めるより、NumPyの`ndarray.sum`を使ったほうが時には何百倍も高速になります。また、記述量も1行で済みます。

ライブラリを適切に使いこなし、効果的にPythonを使っていきましょう。
