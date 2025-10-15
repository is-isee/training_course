# Python の基礎文法


この資料では、 Python の基礎的な文法を紹介する。

以下の `Open in Colab` ボタンを押すと、Colab
上で現在閲覧しているノートブックを開く事ができる。

[![](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/is-isee/training_course/blob/main/docs/python/basic.ipynb)

## セルの基本操作

Notebook
には**セル**という単位が存在し、コードの入力や実行はセルごとに行われる。
そこで、まずセルの操作方法を紹介する。

### セルの挿入

画面上部に「＋コード」や「＋テキスト」などのボタンがある。
これを押すとそれぞれ**コードセル**、**テキストセル**が追加され、Pythonコードや説明文(Markdown形式)が書けるようになる。
この説明文もテキストセルに記述している。

Markdownについては詳しく説明しないが、数式等も書けるテキスト形式だと考えれば良い。
詳細はこの授業の趣旨から外れるので、興味がある人は各自調べて欲しい。

### セルの入力

セルをクリックすると入力モードに変わり、キーボードでテキストやコードを入力出来る。

### セルの実行

セルにポインタ載せ、左上の再生ボタン ▶️ を押すとセルが実行される。

### セルの移動

セルをクリックし、右上の上下の矢印ボタン ↑↓
を押すとセルが上下の隣接セルと入れ替わる。

### セルの削除

セルをクリックし、右上のゴミ箱ボタン 🗑️ を押すとセルが削除される。

### 演習: セルの基本操作

1.  このセルの下に、コードセルとテキストセルを一つづつ挿入せよ。
2.  コードセルに `print("Hello World!")` と入力し、セルを実行せよ。
3.  作成したコードセルとテキストセルを上下に入れ替えよ。
4.  作成した両セルを削除せよ。

### 注意: Notebook におけるセルの実行順序について

Notebook において、セル内で定義した変数や関数は別のセルで利用出来る。
ただし、その内部状態はセルの実行順序に依存し、表示されている順序に依らない。

意図しない挙動を避けるため、セルは上から順番に実行することをおすすめする。
全体を一度に実行するために、上部のツールバーには**すべてのセルを実行**というボタンがあるので、適宜活用して欲しい。

## リテラル (固定値)

以下のようなリテラルが存在する。

| 例              | 型                     | 値                      |
|-----------------|------------------------|-------------------------|
| `1`, `-50`      | `int` (符号付き整数)   | $1$, $-50$              |
| `1.0`, `3.e-5`  | `float` (浮動小数点数) | $1$, $3 \times 10^{-5}$ |
| `True`, `False` | `bool` (論理型)        | 真, 偽                  |
| `"a"`, `"abc"`  | `str` (文字列型)       | “a”, “abc”              |

各リテラルの型は以下のように確認出来る。

``` python
type(3.14)
```

    float

``` python
type("Hello!")
```

    str

複数行の文字列リテラルは以下のように書くことも出来る。

``` python
"""
これは
複数行の
文字列です
"""
```

    '\nこれは\n複数行の\n文字列です\n'

## `print` 文

C言語のコード

``` c
printf("Hello World\n");
```

に相当するPythonのコードは以下のようになる。

``` python
print("Hello World")
```

末尾の改行文字 `\n` は不要である。

``` python
print("This is 1st line.")
print("This is 2nd line.")
```

    This is 1st line.
    This is 2nd line.

自動で型を認識して出力してくれる。改行文字などの特殊文字も利用出来る。

``` python
print("a = ", 1, "\nb = ", 3.14, "\ntype(b) = ", type(3.14))
```

    a =  1 
    b =  3.14 
    type(b) =  <class 'float'>

ここまで`print`文を使わなくても値が得られていたことを不思議に思うかもしれない。
これは、セル内で最後に実行した文の返り値をNotebookが出力してくれるためである。

``` python
"Hello World!"
```

    'Hello World!'

## 変数の定義

C言語のコード

``` c
int n = 128;
double pi = 3.14;
char text[] = "Hello";
```

に対応するPythonコードは

``` python
n = 128
pi = 3.14
text = "Hello"
```

である。
Pythonでは型は明示的に指定する必要はなく、実行時に動的に判断される。

同じ変数名を異なる意味で使い回すことも出来るが、バグの元なので避けるべきである。

``` python
a = 1
print(a)
a = 3.14
print(a)
a = "Hello"
print(a)
```

    1
    3.14
    Hello

## コメント

``` python
# この行はコメント
print(1)  # 行の途中からでもコメントになる
```

    1

## 各種演算子

変数やリテラルは、それぞれの型に対応した演算子が定義されている。
以下にこのコースでよく使うものを示す。

``` python
print(1 + 2 * 3 - 4)  # 加減乗
print(4 / 3, 4 // 3)  # int型への除算 / は float に変換される。切り捨ては // を使う。
print(2.0**3)  # べき乗
print(3**2 == 9, 3 < 2, 4 <= 4)  # 比較
```

    3
    1.3333333333333333 1
    8.0
    True False True

ここで、`#` 以降はコメント文として扱われる。

## 条件分岐

`if` 文を用いて以下のように書ける。

``` python
price_apple = 150  # りんご 1 個あたり 150 円
price_banana = 200  # バナナ 1 個あたり 200 円
if price_apple < price_banana:
    print("りんごが安い")
else:
    print("バナナが安い")
```

    りんごが安い

ここで注意したいのが、Pythonにおけるインデントの重要性である。
例えば、上のコードを以下のように書くとエラー (`IndentationError`)
になる。

``` python
if (price_apple < price_banana):
print("りんごが安い")
else:
print("バナナが安い")
```

また、同じインデントは同じコードブロックと認識され、1つのまとまりとして処理される。

``` python
price_apple = 150  # りんご 1 個あたり 150 円
price_banana = 200  # バナナ 1 個あたり 200 円
if price_apple < price_banana:
    print("りんごが安い")
    print("りんごが安い")
    print("りんごが安い")
else:
    print("バナナが安い")
    print("バナナが安い")
    print("バナナが安い")
```

    りんごが安い
    りんごが安い
    りんごが安い

## 繰り返し

`for` 文を用いて以下のように書ける。

``` python
for i in range(0, 3):
    print(i)
```

    0
    1
    2

ここで、`i == 3` の場合は実行されないことに注意する。
`range(start, stop, step)`
は組み込み関数で、順序付きの整数の並びを生成する。

- `start`: どこから始めるか
- `stop`: どこで終わるか
- `step`: いくつづつ増やすか (省略時は `1`)

上記のPythonコードを以下のC言語コードに対応する。

``` c
for (int i = 0; i < 3; ++i) {
  printf("%d\n", i);
}
```

`break` 文を使うと `for` 文を途中で停止出来る。

``` python
for i in range(0, 10000):  # 何もしなければ 1 万回繰り返されるループ
    print(i)
    if i == 5:  # 変数 i の値が 5 に等しいとき次の文を実行
        break  # break 文が実行されると for 文は終了
```

    0
    1
    2
    3
    4
    5

## 関数

関数は以下のように定義出来る。

``` python
def add(a, b):
    return a + b
```

定義した関数は以下のように呼び出せる。引数・返り値の型は実行時に判断される。

``` python
print(add(1, 2))
print(add(3.0, -2.5))
```

    3
    0.5

関数呼び出しでは、どの引数にどのリテラル・変数を対応させるかを明示的に指定できる。

``` python
def sub(a, b):
    return a - b


print(sub(a=1, b=2))
print(sub(b=-3.0, a=2.5))
```

    -1
    5.5

積極的に利用することで、引数が多い関数 (目安は4-5個以上)
を呼び出す際にバグを減らすことができる。

## 組み込みデータ構造

Pythonには便利なデータ型が組み込まれている。 以下では `list` 型と `dict`
型を紹介する。

連結リストは `list` 型である。

``` python
a = [1, 2, 3]
print(a)

a.append(4)
print(a)

a.clear()
print(a)
```

    [1, 2, 3]
    [1, 2, 3, 4]
    []

`for` 文と組み合わせると便利に使える。

``` python
b = [1, "c", 3.14]
for e in b:
    print(e)
```

    1
    c
    3.14

添字でアクセスすることも出来る。

``` python
for i in range(0, len(b)):  # len(b) は b の要素数を返す
    print(i, b[i])
```

    0 1
    1 c
    2 3.14

`in` を使うと要素がリストに含まれるかを判別できる。

``` python
print('a' in b)
print('c' in b)
print(1 in b)
```

    False
    True
    True

連想配列は `dict` 型 (辞書型)
である。C言語の構造体の代わりにも使いやすい。

``` python
d = {}
d['a'] = 2
d[2] = 5.14
d[3.14] = "pi"
print(d)
```

    {'a': 2, 2: 5.14, 3.14: 'pi'}

``` python
print(d[3.14])
print(d[2])
```

    pi
    5.14

`for`文との組み合わせは、添字(キー)、値、その両者のそれぞれで3通りが代表的である。

``` python
for key in d.keys():
    print(key)
```

    a
    2
    3.14

``` python
for value in d.values():
    print(value)
```

    2
    5.14
    pi

``` python
for key, value in d.items():
    print(key, value)
```

    a 2
    2 5.14
    3.14 pi

## 演習: フィボナッチ数列の計算

フィボナッチ数列 $F_n$ は以下のように定義される。 $$
F_0 = 0
$$ $$
F_1 = 1
$$ $$
F_n = F_{n-1} + F_{n-2}\quad \text{if }\ \ n \ge 2
$$ 引数 $n$ に対して $F_n$ を返す関数 `fib(n)` を実装せよ。

``` python
# ここに自分の解答を入力
```
