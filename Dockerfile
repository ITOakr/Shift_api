# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t app .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name app app

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.2
FROM ruby:3.2.2

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

# 作業ディレクトリの設定
WORKDIR /app

# Gemfileをコピー
COPY Gemfile ./

# Bundlerのインストールと依存関係の解決
RUN bundle install

# アプリケーションのコードをコピー
COPY . .

# ポート3002を公開
EXPOSE 3002

# サーバーの起動
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3002"]
