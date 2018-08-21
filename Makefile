include .env

MYSQL_DUMPS_DIR=./data

start:
	docker-compose --file docker-compose.yml up -d

start-single-player:
	docker-compose --file docker-compose-single-player.yml up -d

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
	@mkdir -p $(MYSQL_DUMPS_DIR)
	docker exec $(shell docker-compose ps -q mysqldb) mysqldump --all-databases -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" | gzip > $(MYSQL_DUMPS_DIR)/`date "+%Y%m%d %H%M %Z"`.sql.zip

backup-windows:
	@docker exec -i mysql mysqldump --all-databases -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" > $(MYSQL_DUMPS_DIR)/db.sql

restore:
	docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < $(MYSQL_DUMPS_DIR)/db.sql

restore-windows:
	@docker exec -i mysql mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < $(MYSQL_DUMPS_DIR)/db.sql

import-game:
	@docker exec -i $(shell sudo docker-compose ps -q mysqldb) mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < Game/Databases/openrsc_config.sql 2>/dev/null
	@docker exec -i $(shell sudo docker-compose ps -q mysqldb) mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < Game/Databases/openrsc_logs.sql 2>/dev/null
	@docker exec -i $(shell sudo docker-compose ps -q mysqldb) mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < Game/Databases/openrsc.sql 2>/dev/null
	@docker exec -i $(shell sudo docker-compose ps -q mysqldb) mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < Game/Databases/openrsc_tools.sql 2>/dev/null

import-website:
	@docker exec -i $(shell sudo docker-compose ps -q mysqldb) mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < Website/openrsc_forum.sql 2>/dev/null

import-ghost:
	@docker exec -i $(shell sudo docker-compose ps -q mysqldb) mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < ghost.sql 2>/dev/null

import-wiki:
	@docker exec -i $(shell sudo docker-compose ps -q mysqldb) mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < Website/Wiki/openrsc_wiki.sql 2>/dev/null

import-windows-game:
	@docker exec -i mysql mysql -u"root" -p"root" < Game/Databases/openrsc_logs.sql
	@docker exec -i mysql mysql -u"root" -p"root" < Game/Databases/openrsc_config.sql
	@docker exec -i mysql mysql -u"root" -p"root" < Game/Databases/openrsc.sql
	@docker exec -i mysql mysql -u"root" -p"root" < Game/Databases/openrsc_tools.sql

import-windows-website:
	@docker exec -i mysql mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < Website/openrsc_forum.sql

import-windows-ghost:
	@docker exec -i mysql mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < ghost.sql

import-windows-wiki:
	@docker exec -i mysql mysql -u"$(MARIADB_ROOT_USER)" -p"$(MARIADB_ROOT_PASSWORD)" < Website/Wiki/openrsc_wiki.sql

flush:
	@$(shell sudo rm -rf Website && sudo rm -rf Game)

flush-windows:
	@rmdir "Website" /s /Q
	@rmdir "Game" /s /Q

.PHONY: clean test code-sniff init
