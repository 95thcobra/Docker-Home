# Makefile for Docker Nginx PHP Composer MySQL

include .env

# MySQL
MYSQL_DUMPS_DIR=data/db/dumps

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  pull			           Get the latest GitHub repos"
	@echo "  start			         Create and start containers"
	@echo "  stop								 Stop all services"
	@echo "  restart			       Restart containers"
	@echo "  logs                Follow log output"
	@echo "  import        Import all databases from the GitHub repos"
	@echo "  dump          Create backup of all local databases"
	@echo "  restore       Restore backup of all local databases"

start: init
	docker-compose up -d

stop:
	@docker-compose down -v

restart:
	@docker-compose down -v
	docker-compose up -d

pull:
	@$(shell git clone https://github.com/Marwolf/Open-RSC-Website.git)
	cd Open-RSC-Website
	git pull
	cd ..
	@$(shell git clone https://github.com/Marwolf/Open-RSC)
	cd Open-RSC
	git pull
	cd ..

gen-certs:
	@docker run --rm -v $(shell pwd)/etc/ssl:/certificates -e "SERVER=$(NGINX_HOST)" jacoelho/generate-certificate

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

resetOwner:
	@$(shell chown -Rf $(SUDO_USER):$(shell id -g -n $(SUDO_USER)) $(MYSQL_DUMPS_DIR) "$(shell pwd)/etc/ssl" 2> /dev/null)

.PHONY: clean test code-sniff init
