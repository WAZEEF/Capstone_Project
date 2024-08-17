#!/bin/bash

echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

if [ "$GIT_BRANCH" = "origin/dev" ]; then
	docker tag project wazeef/dev:dev
	docker push wazeef/dev:dev
elif [ "$GIT_BRANCH" = "origin/main" ]; then
	docker tag project wazeef/prod:prod
	docker push wazeef/prod:prod
else
	echo "No branch detected !!!"

fi

export COMPOSE_HTTP_TIMEOUT=500

docker-compose down || true

docker-compose up -d 
