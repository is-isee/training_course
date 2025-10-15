# VSCode (Visual Studio Code) 入門

[VSCode (Visual Studio Code)](https://code.visualstudio.com/) は無料で利用できる統合開発環境で、Windows/macOS/Linuxで動作します。
非常に多くの機能があるため、詳しい利用方法は[公式ドキュメント](https://code.visualstudio.com/docs)を参照してください。

## VSCodeのインストール

VSCodeのインストール方法は、[公式ドキュメント](https://code.visualstudio.com/docs/setup/setup-overview)を参照してください。

## コマンドパレット

VSCodeの多くの機能はコマンドパレットから利用できます。
コマンドパレットは `Cmd+Shift+P` (Mac) または `Ctrl+Shift+P` (Windows/Linux) で開くことができます。

## `code` コマンドの利用

VSCodeは公式のCLIツールとして `code` コマンドが用意されています。
`code` コマンドを利用すると、コマンドラインからVSCodeを起動したり、ファイルやディレクトリを開いたりすることができます。
VSCodeのコマンドパレット ( `Cmd+Shift+P` または `Ctrl+Shift+P` ) を開き、`> Shell Command: Install 'code' command in PATH` を選択してインストール出来ます。

## ワークスペース

VSCodeで作業する際に最初にやるべきことは、ディレクトリを開くことです。
このディレクトリをVSCodeではワークスペースと呼びます。

VSCodeでは、各プロジェクトをワークスペースの単位で管理することが推奨されています。
ワークスペースの中には色々なファイルやディレクトリを置くことが出来ます。
ワークスペースでは共通の設定を行うことができるため、プロジェクトそれぞれで異なる設定を行うことができます。

以下は、ディレクトリを作成し、VSCodeで開く手順です。

```shell
mkdir my_project
cd my_project
code .
```

ユーザーが設定を変更するとディレクトリ `my_project/.vscode` というディレクトリが作成され、その中にワークスペース内でのVSCodeの動作に関する設定ファイル `my_project/.vscode/settings.json` が作成されます。
設定ファイルを変更するには、コマンドパレットを開き、`> Preferences: Open Workspace Settings (JSON)` を選択します。
`> Preferences: Open Workspace Settings` を選択すると、GUIで設定を変更することもできます。

## ターミナルを開く

VSCodeにはターミナルが内蔵されており、Ctrl + Shift + ` (back quote) で開くことが出来ます。
ターミナルを開くと、ワークスペースのルートディレクトリがカレントディレクトリとして設定されます。

## ファイルを開く

VSCodeでファイルを開く方法は様々ありますが、おすすめは Quick Open 機能を使う方法です。
`Cmd+P` (Mac) または `Ctrl+P` (Windows/Linux) で上部に入力ボックスが表示され、そこにファイル名を入力することで、ディレクトリ内に存在するファイルを素早く開くことができます。

また、`code` コマンドを使ってコマンドラインからファイルを開くこともできます。
ターミナルでの作業からファイルの編集へスムーズに移行したい場合に便利です。

```shell
code myfile.txt
```

## 演習: ワークスペースの作成とファイルの編集

1. ターミナルを開き、`my_project` というディレクトリを作成し、その中に移動します。
2. `code .` コマンドでVSCodeを起動します。
3. コマンドパレットを開き、`> Preferences: Open Workspace Settings (JSON)` を選択します。
4. `settings.json` ファイルに以下の内容を追加します。これにより、1000ミリ秒 (1秒) ごとに編集中のファイルが自動で保存されるようになります。

   ```json
   {
       "files.autoSave": "afterDelay",
       "files.autoSaveDelay": 1000
   }
   ```

5. ファイル `hello.txt` を作成し、`Hello, VSCode!` と入力して保存します。
6. ターミナルを開き、`cat hello.txt` コマンドでファイルの内容を確認します。

## 拡張機能のインストール

VSCodeは拡張機能をインストールすることで、様々な機能を追加することができます。
拡張機能のインストールは、コマンドパレットを開き、`> Extensions: Install Extensions` を選択するか、左側のサイドバーにある四角いアイコンをクリックして行います。
ウェブ上のマーケットプレイスから拡張機能を検索し、インストールすることもできます。

## 演習: Python拡張機能のインストール

1. コマンドパレットを開き、`> Extensions: Install Extensions` を選択します。
2. 検索ボックスに "Python" と入力し、Microsoftが提供している[Python拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-python.python)をインストールします。
3. インストールが完了したら、VSCodeを再起動します。

## リモートサーバへの接続

VSCodeはリモートサーバへSSHで接続し、リモートサーバ上のファイルを編集することができます。
リモートサーバへ接続するには、[Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) という拡張機能をインストールします。
拡張機能のインストールは、左側のサイドバーにある四角いアイコンをクリックし、検索ボックスに "Remote - SSH" と入力して行います。

## (Windows のみ) WSLの利用

Windows 上で研究や開発を行う場合、WSL (Windows Subsystem for Linux) を利用することをお勧めします。
WSLを利用することで、Linux上で動作する多くのツールをWindows上で利用できるようになります。
WSLの導入方法については、[Microsoftの公式ドキュメント](https://learn.microsoft.com/ja-jp/windows/wsl/install)を参照してください。

VSCode はMicrosoft製のソフトウェアであり、WSL2上で動作するVSCodeをWindows上で利用することができます。
VSCodeでWSLへ接続する方法については、[こちらのドキュメント](https://learn.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-vscode)を参照してください。

## 共用サーバへ接続する際の注意点

VSCodeはバックグラウンドで多数のプロセスを立ち上げます。複数人で利用する共用サーバで一人のユーザーが多数のプロセスを立ち上げると他ユーザーの利用の妨げになる場合があります。
共用サーバへのVSCodeを利用した接続はなるべく避け、`rsync`や`git`を用いたファイル同期やバージョン管理を中心に行うことを推奨します。
