# コンテナ起動
up:
	docker compose up -d

# コンテナ停止
down:
	docker compose down

# コンテナイメージボリューム削除
destroy:
	docker compose down --rmi all --volumes --remove-orphans

# コンテナビルド
build:
	docker compose build --no-cache --force-rm

# webシェルログイン
web:
	docker compose exec django_app bash

# dbコンテナログイン
db:
	docker exec -it db bash


