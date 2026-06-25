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

### その他の方法

WindowsやmacOS以外の環境でも、Linuxを利用できる方法はいくつかあります。ただし、各自の研究活動における利用を考えると、自分のPC上でLinuxを利用できる環境を整えることをおすすめします。

- Linuxを直接インストール
  - [Ubuntu](https://ubuntu.com/download/desktop) などのLinuxディストリビューションを直接インストールする方法です。W
  - 不要なPCがあれば、最も安定してLinux環境を利用出来ます。
- [GitHub Codespaces](https://github.com/features/codespaces)
  - GitHub上のリポジトリをブラウザ上の VS Code 風環境で開き、Linuxとして利用できます。
  - 無料で使用可能ですが、利用時間・ストレージに上限があり課金対象となるため注意してください。
  - GitHub Education の認証済み学生は、無料枠が増えるようです。
- [Google Colab](https://colab.research.google.com/)
  - 本来はPythonのJupyter Notebook用の実行環境ですが、「ツール > コマンドパレット > ターミナルを表示」によりLinuxのターミナル機能を利用可能です。
