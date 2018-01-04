UNAME := $(shell uname -s)
COMPOSE=docker-compose
RUN=$(COMPOSE) run --rm tools
THEMEPS=$(RUN) themeps
COMPOSER=composer

all: start install
reload: build start

# --------------------------- #
# MAIN
# --------------------------- #

start:
	$(COMPOSE) up -d

build:
	$(COMPOSE) down
	$(COMPOSE) build

install:
	$(RUN) $(COMPOSER) install --no-interaction --prefer-dist

ps_webpack:
	$(THEMEPS) npm run build && $(THEMEPS) npm run watch
