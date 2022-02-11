#!/usr/bin/env sh

source $PWD/.envrc

if [ $1 == "start" ]; then
    if [ ! -d $PGHOST ]; then
        mkdir -p $PGHOST
        echo 'Initializing postgres database'
        initdb -U postgres $PGDATA --auth=trust >/dev/null
        echo 'Starting postgres'
        chmod -R 0700 $PGDATA
        pg_ctl start -l $LOG_PATH -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"
        psql -c "alter user postgres with superuser;"
    else
        echo 'Starting postgres'
        chmod -R 0700 $PGDATA
        pg_ctl start -l $LOG_PATH -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"
    fi
fi

if [ $1 == "stop" ]; then
    echo 'Stopping postgres'
    pg_ctl stop -l $LOG_PATH -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"
fi

exit 0
