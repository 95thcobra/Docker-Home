MYSQL_DUMPS_DIR=./data/db

start: init
	docker-compose up -d --remove-orphans

stop:
	@docker-compose down -v

restart: init
	@docker-compose down -v
	docker-compose up -d

clone-game:
	@$(shell git clone https://github.com/Open-RSC/Game.git)

clone-website:
	@$(shell git clone https://github.com/Open-RSC/Website.git)

clone-wiki:
	@$(shell cd Website && git clone https://github.com/Open-RSC/Wiki.git)

clone-windows-website:
	@git clone https://github.com/Open-RSC/Website.git

clone-windows-game:
	@git clone https://github.com/Open-RSC/Game.git

clone-windows-wiki:
	@git clone https://github.com/Open-RSC/Wiki.git Website/Wiki

pull-game:
	@cd Game && git pull

pull-website:
	@cd Website && git pull

pull-wiki:
	@cd Website/Wiki && git pull

pull-game-windows:
	@cd Game && git reset HEAD --hard &&  git pull

pull-website-windows:
	@cd Website && git reset HEAD --hard &&  git pull

pull-wiki-windows:
	@cd Website/Wiki git reset HEAD --hard && git pull

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

import-game:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"root" -p"root" < Game/Databases/openrsc_config.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"root" -p"root" < Game/Databases/openrsc_logs.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"root" -p"root" < Game/Databases/openrsc.sql 2>/dev/null
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"root" -p"root" < Game/Databases/openrsc_tools.sql 2>/dev/null

import-website:
	#@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"root" -p"root" < Website/openrsc_forum.sql 2>/dev/null

import-wiki:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"root" -p"root" < Website/Wiki/openrsc_wiki.sql 2>/dev/null

import-windows-game:
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc_logs.sql
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc_config.sql
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc.sql
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Game/Databases/openrsc_tools.sql

import-windows-website:
	#@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Website/openrsc_forum.sql

import-windows-wiki:
	@docker exec -i mysql mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < Website/Wiki/openrsc_wiki.sql

flush:
	@$(shell rm -rf Website && rm -rf Game)

flush-windows:
	@rmdir "Website" /s /Q
	@rmdir "Game" /s /Q

.PHONY: clean test code-sniff init
