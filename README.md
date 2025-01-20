# Restaurant Searcher

## URL
https://restaurantsearcher.onrender.com/

## 提出用ドキュメント
[簡易仕様書.md](./簡易仕様書.md)

## 開発環境構築
### Requirements
- Ruby 3.2.2
- sqlite3
- nodejs
- libyaml-dev
- libffi-dev
- ruby gem
    - bundler
    - rails 7.1.5.1

### 環境構築補足 (ubuntu 22.04LTS, WSL)

### 依存関係
```bash
$ sudo apt update
$ sudo apt install splite3
$ sudo apt install nodejs
$ sudo apt install libyaml-dev libffi-dev
```

### rubyの環境構築
```bash
$ sudo apt install rbenv
$ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build 
$ rbenv install 3.2.2 # Rubyのインストール
$ rbenv global 3.2.2 # Ruby Version切り替え
```

### gemのインストール
```bash
$ gem install bundler
$ gem install rails -v "7.1.5.1"
```

### 実行コマンド
```bash
$ bundle install
$ rails s
```
