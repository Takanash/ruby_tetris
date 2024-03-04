Ruby Tetris (No curses)

# 準備
```shell
docker compose build
docker compose run --rm app bundle install
```

# 実行
```shell
docker compose run --rm app bin/ruby src/tetris.rb
```

※ bin/rubyでGemfileのライブラリを読み込んだ上でファイルを実行する
  例えばdebuggerでブレークポイントの設定が可能

