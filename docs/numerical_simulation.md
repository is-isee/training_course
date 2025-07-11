# 数値計算入門

本記事は執筆中です。

## 前提条件

Python、NumPy、Matplotlibの基礎は学習済みとします。
自信がない場合は本コース内Python入門を確認してください。

## 数値計算と誤差

- 丸め誤差
- 桁落ち
- 離散化誤差

## 常微分方程式

- Runge-Kutta法
- Buneman-Boris法
- **演習**: 荷電粒子の運動とエネルギー保存

## 偏微分方程式(1)

- 中央差分法
- CFL条件
- Odd-even デカップリング、スタッガード格子、Yee格子
- **演習**: スカラー移流拡散方程式とスカラー保存
- 双曲型システム方程式と固有値・固有ベクトル
- **演習**: 波動方程式(音波 or 表面重力波 or Maxwell方程式)

## 行列計算

- 固有値と固有ベクトルの復習
- 条件数と反復回数
- 行列計算の誤差
- **演習**: 電離反応方程式と安定性
- 密行列と疎行列
- Jacobi法とCFL条件
- **演習**: ポアソン方程式
  - 備考: 片側からCTCSで陽解法的積分も可能

## シンボリックな数値計算

- SymPy
