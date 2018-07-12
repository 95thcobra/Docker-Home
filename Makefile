# Makefile for Docker Nginx PHP Composer MySQL

include .env

# MySQL
MYSQL_DUMPS_DIR=./data/db

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
	@$(shell git clone https://github.com/Open-RSC/Website.git)
	@$(shell git clone https://github.com/Open-RSC/Game.git)
	@$(shell sudo chmod -R 777 Website && sudo chmod -R 777 Game && sudo chmod 644 Website/board/config.php)

clone-windows-website:
	@git clone https://github.com/Open-RSC/Website.git
	#icacls Website/Open-RSC-Website /grant Everyone:F /t

clone-windows-game:
	@git clone https://github.com/Open-RSC/Game.git
	#icacls Game/Open-RSC-Game /grant Everyone:F /t

pull:
	@$(shell cd Website && git pull)
	@$(shell cd Game && git pull)

pull-windows:
	@cd Website && git pull
	@cd Game && git pull

logs:
	@docker-compose logs -f

backup:
	@sudo mkdir -p $(MYSQL_DUMPS_DIR)
	@$(shell sudo chmod -R 777 $(MYSQL_DUMPS_DIR))
	@docker exec $(shell docker-compose ps -q mysqldb) mysqldump --all-databases -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" > $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null

backup-windows:
	@docker exec -i mysql mysqldump --all-databases -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" > $(MYSQL_DUMPS_DIR)/db.sql

restore:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null

restore-windows:
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < $(MYSQL_DUMPS_DIR)/db.sql

import:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc_config.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc_logs.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Website/openrsc_forum.sql 2>/dev/null

import-windows:
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Website/openrsc_forum.sql
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc_logs.sql
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc_config.sql
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc.sql

flush:
	@$(shell rm -rf Website && rm -rf Game)

flush-windows:
	@rmdir "Website" /s /Q
	@rmdir "Game" /s /Q

.PHONY: clean test code-sniff init
