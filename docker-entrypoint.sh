#!/bin/bash
set -e

set_db_config() {
	key="$1"
	value="$2"
	sed_escaped_value="$(echo "$value" | sed 's/[\/&]/\\&/g')"
	sed -ri "s/^(\s*$key)\s*=\s*.*/\1 = \"$sed_escaped_value\"/" jbilling/jbilling-DataSource.groovy
}

if [ "$POSTGRES_PORT_5432_TCP" ]; then
	set_db_config dialect 'org.hibernate.dialect.PostgreSQLDialect'
	set_db_config driverClassName 'org.postgresql.Driver'
	set_db_config username "${JBILLING_DB_USERNAME:-postgres}"
	set_db_config password "${JBILLING_DB_PASSWORD:-}"
	set_db_config url "jdbc:postgresql://${POSTGRES_PORT_5432_TCP#tcp://}/${JBILLING_DB_NAME:-jbilling}"
else
	echo >&2 'warning: http://www.jbilling.com/documentation/users/database-guide'
	echo >&2 '  (docker run --link some-postgres:postgres ...)'
	sleep 5
fi

exec "$@"
