#unite-project


##概要

Project.vim用のプロジェクト定義ファイルからunite.vimのsourceを作成するプラグインです。


##コマンド

###:Unite project_files
Uniteコマンドにproject_filesを指定して実行。
`g:unite-project_target_file`で指定されたプロジェクト定義ファイルが使用される。


##カスタマイズ

###g:unite-project_target_file
Project.vimのプロジェクト定義ファイルのパスの指定。
デフォルトはカレントディレクトリの'.vimprojects'が設定される。
