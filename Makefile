# Makefile for Docker Nginx PHP Composer MySQL

include .env

# MySQL
MYSQL_DUMPS_DIR=data/db/dumps

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  clone					Clone the GitHub repos"
	@echo "  pull						Get the latest GitHub repo updates"
	@echo "  start					Create and start containers"
	@echo "  stop						Stop all services"
	@echo "  restart				Restart containers"
	@echo "  logs						Follow log output"
	@echo "  import					Import all databases from the GitHub repos"
	@echo "  dump						Create backup of all local databases"
	@echo "  restore				Restore backup of all local databases"
	@echo "  flush					Delete local GitHub repos"
	@echo ""

start: init
	docker-compose up -d

stop:
	@docker-compose down -v

restart: init
	@docker-compose down -v
	docker-compose up -d

clone:
	@$(shell git clone https://github.com/Marwolf/Open-RSC-Website.git && git clone https://github.com/Marwolf/Open-RSC)
	@$(shell git clone https://github.com/Marwolf/Open-RSC)
	@$(shell sudo chmod -R 777 Open-RSC-Website/board/cache/ && sudo chmod 644 Open-RSC-Website/board/config.php)

pull:
	@$(shell cd Open-RSC-Website && git pull && cd .. && cd Open-RSC && git pull && cd ..)
	@$(shell sudo chmod -R 777 Open-RSC-Website/board/cache/ && sudo chmod 644 Open-RSC-Website/board/config.php)

logs:
	@docker-compose logs -f

dump:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	@docker exec $(shell docker-compose ps -q mysqldb) mysqldump --all-databases -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" > $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null
	@make resetOwner

restore:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null

import:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Open-RSC/Databases/openrsc_config.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Open-RSC/Databases/openrsc_logs.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Open-RSC/Databases/openrsc.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Open-RSC-Website/openrsc_forum.sql 2>/dev/null

flush:
	@$(shell rm -rf Open-RSC-Website && rm -rf Open-RSC)

resetOwner:
		@$(shell chown -Rf $(SUDO_USER):$(shell id -g -n $(SUDO_USER)) $(MYSQL_DUMPS_DIR) "$(shell pwd)/etc/ssl" 2> /dev/null)

.PHONY: clean test code-sniff init
