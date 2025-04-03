# 開発者用のメモ

## 開発の流れ (誰でもOK)

1. リポジトリをfork
2. `upstream`にオリジナルのリモートリポジトリを設定
3. イシューのアサインをメンテナに依頼する
4. イシューがアサインされる
5. ブランチを切る
6. 編集作業
7. `upstream`にプルリクエストの作成

## 開発の流れ (総合解析内部の人向け)

1. リポジトリのメンバーへの加入をメンテナに依頼する
2. リポジトリをローカルにクローン
3. イシューをアサイン
4. ブランチを切る
5. 編集作業
6. プルリクエストの作成

## 依存ライブラリの導入

```shell
python -m venv venv
. venv/bin/activate
pip install -r requirements.txt
```

## `MkDocs` の利用方法

```shell
# ローカルでの見栄え確認
mkdocs serve
# 表示されたURLにブラウザでアクセス

# HTMLファイルの生成
mkdocs build

# 目次・テーマ等の設定
vi mkdocs.yml

# GitHub Pagesへのデプロイ設定
vi .github/workflows/static.yml
```

## 画像の挿入

- リポジトリにラスター画像を重くなるため、必要性やサイズを慎重に選択する。
- 単純な模式図であれば `PlantUML`、 `Mermaid` や `draw.io` などの利用を検討する。
