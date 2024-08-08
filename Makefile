
dc = docker-compose

rebuild:
	$(dc) build --no-cache

build:
	$(dc) build 

run: build
	$(dc) run --service-ports gitserver

start: build
	$(dc) up -d gitserver

stop:
	$(dc) down --remove-orphans

ps:
	$(dc) ps

tail:
	$(dc) logs --follow

kill:
	docker ps | awk '/minimal-git-server/{print $$1}' | xargs -n 1 -r docker stop


.PHONY: rebuild build run start stop kill
