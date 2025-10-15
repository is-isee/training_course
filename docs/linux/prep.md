# 事前準備

「Linux 入門」へ進む前に、以下の準備を行ってください。

## ターミナルと Linux 環境の準備

### Windowsの場合

WSL (Windows Subsystem for Linux) を使うとWindows上でLinuxを利用できます。公式情報は <https://learn.microsoft.com/ja-jp/windows/wsl/install> にあります。

まず PowerShell またはコマンドプロンプトから以下のコマンドを実行し、画面に表示される指示に従う (おそらく再起動が必要になる)。

```powershell
PS C:\Users\<username>> wsl --install
```

スタートメニューに Ubuntu がアプリとして追加されるはずです。
Ubuntu を実行し、ユーザーとパスワードの設定を行ってください。

### macOSの場合

BSD UNIXがベースなのでもともとインストールされている `ターミナル.app` を使うことができます。
