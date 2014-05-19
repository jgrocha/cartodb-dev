#!/usr/bin/env bash

cd /usr/local/src/cartodb
bundle install

mv config/app_config.yml.sample config/app_config.yml
mv config/database.yml.sample config/database.yml

# get postgres to drop all security
mv /etc/postgresql/9.1/main/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf.original
ln -s /usr/local/etc/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf

/etc/init.d/postgresql restart

# jgr
# Error: schema cartodb does not exist
# cp lib/sql/scripts-available/CDB_SearchPath.sql lib/sql/scripts-available/CDB_SearchPath.sql.old
# cp /usr/local/etc/CDB_SearchPath.sql lib/sql/scripts-available/CDB_SearchPath.sql
rm lib/sql/scripts-available/CDB_SearchPath.sql

# jgr
sudo sysctl vm.overcommit_memory=1
echo 'vm.overcommit_memory = 1' | sudo tee -a /etc/sysctl.conf
	
# jgr
redis-server &

sleep 5s

export USER=monkey
export SUBDOMAIN=${USER}
export PASSWORD=monkey
export ADMIN_PASSWORD=monkey
export EMAIL=monkey@example.com

echo "127.0.0.1 ${USER}.localhost.lan" | sudo tee -a /etc/hosts

# lib/tasks/setup.rake

bundle exec rake rake:db:create
bundle exec rake rake:db:migrate
bundle exec rake cartodb:db:create_publicuser
bundle exec rake cartodb:db:create_user SUBDOMAIN="${USER}" PASSWORD="${PASSWORD}" EMAIL="${EMAIL}"
# jgr
# bundle exec rake cartodb:db:create_importer_schema
bundle exec rake cartodb:db:create_schemas
bundle exec rake cartodb:db:load_functions

ln -s /usr/local/etc/cartodb.development.js /usr/local/src/CartoDB-SQL-API/config/environments/development.js
ln -s /usr/local/etc/windshaft.development.js /usr/local/src/Windshaft-cartodb/config/environments/development.js

redis-cli save
redis-cli shutdown
