.PHONY: setup up down

setup:
	docker-compose build
	docker-compose run --rm web bundle install
	docker-compose run --rm web bundle exec rails db:create db:migrate
	docker-compose run --rm web bundle exec rails generate rspec:install

up:
	docker-compose up

down:
	docker-compose down

# データベースのリセット
reset-db:
	docker-compose run --rm web bundle exec rails db:drop db:create db:migrate

# テストの実行
test:
	docker-compose run --rm web bundle exec rspec

# コンソールの起動
console:
	docker-compose run --rm web bundle exec rails console

# データベースのコンソール起動
db-console:
	docker-compose run --rm web bundle exec rails dbconsole 