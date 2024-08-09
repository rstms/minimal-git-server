
dc = docker-compose
service != basename $(shell pwd)

rebuild:
	$(dc) build --no-cache --force-rm

build:
	$(dc) build --force-rm

run: build
	$(dc) run --service-ports $(service)

start: build
	$(dc) up -d $(service)

stop:
	$(dc) down --remove-orphans

ps:
	$(dc) ps

tail:
	$(dc) logs --follow

kill:
	$(foreach I,$(shell docker ps | awk '/$(service)/{print $$1}'),docker stop $(I);docker rm $(I);)

clean: stop kill
	$(foreach I,$(shell docker images -a | awk '/$(service)/{print $$1}'),docker rmi -f $(I);)


.PHONY: rebuild build run start stop kill
