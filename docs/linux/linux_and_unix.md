# LinuxとUNIX系OS

## UNIXとは

UNIX（ユニックス）は、1969年にAT&Tベル研究所でKenneth ThompsonとDennis Ritchieによって開発されたオペレーティングシステム（OS）です。

- **特徴**  
  - マルチユーザ／マルチタスクを標榜  
  - ファイルを中心に据えたシンプルな設計（"すべてはファイル"の哲学）  
  - テキスト処理やパイプによる小さなプログラムの組み合わせを重視  
- **歴史的意義**  
  - C言語で再実装されたことで移植性が飛躍的に向上  
  - 後の多くのOS設計に影響を与え、標準化（POSIX）につながった  

## Linuxとは

Linux（リナックス）は、1991年にLinus Torvaldsが発表した**カーネル**（OSの中核部分）です。

- **オープンソース**  
  - GPL（GNU General Public License）で公開
- **カーネルとディストリビューション**  
  - **カーネル**: ハードウェア管理やプロセス管理を担う  
  - **ディストリビューション**: カーネルに各種ユーティリティやパッケージ管理システム、GUIなどを組み合わせた配布形態  
- **代表的ディストリビューション**  
  - **Ubuntu**: 初心者向け、Debian系  
  - **Red Hat Enterprise Linux (RHEL)**: 商用サポートあり  
  - **その他**: Debian、Fedora、Rocky Linux、AlmaLinux、openSUSE など  

## 様々なUNIX系OSとPOSIX

- **UNIX系OSの広がり**  
  - **商用UNIX**: AIX（IBM）、HP‑UX（HPE）、Solaris（Oracle）など  
  - **BSD系**: FreeBSD、OpenBSD、NetBSD — オープンソース版UNIX  
  - **macOS**: Apple製OS。内部はBSD派生のDarwinをベースに独自GUIを搭載  
  - **Linux**: GPLベースで最も普及  
- **IEEE標準規格 POSIX**  
  - Portable Operating System Interfaceの略
  - UNIX系OS間の互換性を保つためのAPI／コマンド仕様  
- **本コースの位置づけ**  
  - UNIX系OSの主要な例として、Linuxの基礎知識および操作方法の習得を目指します
