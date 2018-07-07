# Makefile for Docker Nginx PHP Composer MySQL

include .env

# MySQL
MYSQL_DUMPS_DIR=data/db

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  first					Perform first time setup"
	@echo "  clone					Clone the git repository folders"
	@echo "  pull						Get the latest git repository updates"
	@echo "  start					Create and start containers"
	@echo "  stop						Stop all containers"
	@echo "  restart				Restart all containers"
	@echo "  logs						Display log output"
	@echo "  import					Import all databases from git repositories"
	@echo "  backup					Create backup of all local databases"
	@echo "  restore				Restore backup of all local databases"
	@echo "  flush					Delete local git repository folders"
	@echo ""

start: init
	docker-compose up -d

stop:
	@docker-compose down -v

restart: init
	@docker-compose down -v
	docker-compose up -d

clone:
	@$(shell cd Website && git clone https://github.com/Marwolf/Open-RSC-Website.git)
	@$(shell mkdir Game && cd Game && git clone https://github.com/Marwolf/Open-RSC-Game.git)
	@$(shell sudo chmod -R 777 Website/Open-RSC-Website && sudo chmod -R 777 Game/Open-RSC-Game && sudo chmod 644 Website/Open-RSC-Website/board/config.php)

pull:
	@$(shell cd Website/Open-RSC-Website && git pull)
	@$(shell cd Game/Open-RSC-Game && git pull)

logs:
	@docker-compose logs -f

backup:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	@docker exec $(shell docker-compose ps -q mysqldb) mysqldump --all-databases -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" > Website/$(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null
	@make resetOwner

restore:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Website/$(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null

import:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Open-RSC-Game/Databases/openrsc_config.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Open-RSC-Game/Databases/openrsc_logs.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Open-RSC-Game/Databases/openrsc.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Website/Open-RSC-Website/openrsc_forum.sql 2>/dev/null

flush:
	@$(shell rm -rf Website/Open-RSC-Website && rm -rf Game/Open-RSC-Game)

.PHONY: clean test code-sniff init
