Movable Type プラグイン

Hatena Bookmark User RDF Data プラグイン

記事ページに はてなユーザーオートディスカバリーを出力するためのファンクションタグです。

提供するファンクションタグ：

    <MTHateBUserData>

アーカイブ系テンプレートの　<head>〜</head> 内などに記述します。

インストールと設定；

  インストール
       HateBUserData ファルダを Movable Type の plugins　ディレクトリ下にアップロードします。

  設定：
        ブログごとの設定画面で、Hatena Bookmark User RDF Data のところを開きます。
        自分の はてなID をいれます。

オプション：

with_index

ページフォルダーのindex.xxx にあたるファイル名まで出力したい時のオプションです。
MTEntryTrackBackData タグのオプションと同一です。

<MTHateBUserData with_index="1">

インデックスファイルが、index.html の場合に rdf:about の値として、

    http://www/foo/var/index.html

を出力します。



動作を確認したバージョン：

    Movable Type pro 5.2.3 以降　MTOS 5.2.2 以降


LICENSE:

    GPLv2

2013 labs.markdiary.com