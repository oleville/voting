#!/bin/sh

set -e

until nc -z db 3306;
do
	echo "Waiting for mysql to come up..."
	sleep .5
done

export MYSQL_ROOT_PASSWORD
export RAILS_ENV

echo "Performing migrations..."

rake db:migrate 2>&1

echo "Executing Rails..."

exec rails s 2>&1
