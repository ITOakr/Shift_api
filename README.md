# Attendance API

## 環境情報

- Ruby: 3.2.2
- Rails: 8.0.2
- データベース: 
  - 開発環境: SQLite3
  - 本番環境: PostgreSQL

## 前提条件

- Docker Desktop
- Git

## 環境構築手順

1. リポジトリのクローン
```bash
git clone https://github.com/TsunakawaShunya/attendance-api.git
cd attendance-api
```

2. 環境構築
```bash
make setup
```

3. サーバーの起動
```bash
make up
```

サーバーが起動したら、以下のURLでアクセスできます：
```
http://localhost:3002
```

## 便利なコマンド

- `make up`: サーバーの起動
- `make down`: サーバーの停止
- `make reset-db`: データベースのリセット
- `make test`: テストの実行
- `make console`: Railsコンソールの起動
- `make db-console`: データベースコンソールの起動

## 開発環境のポート

- Rails API: 3002
- PostgreSQL: 5432

## 注意事項

- ポート3000と3001はフロントエンド用に予約されています
- データベースのデータは`postgres_data`ボリュームに保存されます
- 依存関係は`bundle_data`ボリュームに保存されます
