# Python 入門 – 基礎文法

2025-10-15T14:30:39

- [<span class="toc-section-number">1</span> リテラル
  (固定値)](#リテラル-固定値)
- [<span class="toc-section-number">2</span> `print` 文](#print-文)
- [<span class="toc-section-number">3</span> 変数の定義](#変数の定義)
- [<span class="toc-section-number">4</span> コメント](#コメント)
- [<span class="toc-section-number">5</span> 各種演算子](#各種演算子)
- [<span class="toc-section-number">6</span> 条件分岐](#条件分岐)
- [<span class="toc-section-number">7</span> 繰り返し](#繰り返し)
- [<span class="toc-section-number">8</span> 関数](#関数)
- [<span class="toc-section-number">9</span>
  組み込みデータ構造](#組み込みデータ構造)
- [<span class="toc-section-number">10</span> 練習](#練習)

この資料では、 Python の基礎的な文法を紹介する。

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

``` python
type("Hello!")
```

複数行の文字列リテラルは以下のように書くことも出来る。

``` python
"""
これは
複数行の
文字列です
"""
```

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

自動で型を認識して出力してくれる。改行文字などの特殊文字も利用出来る。

``` python
print("a = ", 1, "\nb = ", 3.14, "\ntype(b) = ", type(3.14))
```

ここまで`print`文を使わなくても値が得られていたことを不思議に思うかもしれない。
これは、セル内で最後に実行した文の返り値をNotebookが出力してくれるためである。

``` python
"Hello World!"
```

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

## コメント

``` python
# この行はコメント
print(1)  # 行の途中からでもコメントになる
```

## 各種演算子

変数やリテラルは、それぞれの型に対応した演算子が定義されている。
以下にこのコースでよく使うものを示す。

``` python
print(1 + 2 * 3 - 4)  # 加減乗
print(4 / 3, 4 // 3)  # int型への除算 / は float に変換される。切り捨ては // を使う。
print(2.0**3)  # べき乗
print(3**2 == 9, 3 < 2, 4 <= 4)  # 比較
```

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

## 繰り返し

`for` 文を用いて以下のように書ける。

``` python
for i in range(0, 3):
    print(i)
```

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

関数呼び出しでは、どの引数にどのリテラル・変数を対応させるかを明示的に指定できる。

``` python
def sub(a, b):
    return a - b


print(sub(a=1, b=2))
print(sub(b=-3.0, a=2.5))
```

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

`for` 文と組み合わせると便利に使える。

``` python
b = [1, "c", 3.14]
for e in b:
    print(e)
```

添字でアクセスすることも出来る。

``` python
for i in range(0, len(b)):  # len(b) は b の要素数を返す
    print(i, b[i])
```

`in` を使うと要素がリストに含まれるかを判別できる。

``` python
print('a' in b)
print('c' in b)
print(1 in b)
```

連想配列は `dict` 型 (辞書型)
である。C言語の構造体の代わりにも使いやすい。

``` python
d = {}
d['a'] = 2
d[2] = 5.14
d[3.14] = "pi"
print(d)
```

``` python
print(d[3.14])
print(d[2])
```

`for`文との組み合わせは、添字(キー)、値、その両者のそれぞれで3通りが代表的である。

``` python
for key in d.keys():
    print(key)
```

``` python
for value in d.values():
    print(value)
```

``` python
for key, value in d.items():
    print(key, value)
```

## 練習

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
