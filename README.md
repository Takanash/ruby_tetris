Ruby Tetris

# 準備
```shell
docker compose build
docker compose run --rm app bundle install
```

# 実行
```shell
docker compose run --rm app ruby src/main.rb
```

※ Gemfileのライブラリを読み込んだ上でファイルを実行するため、例えばdebuggerでブレークポイントを設定しデバッグが可能

