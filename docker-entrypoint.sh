#!/bin/bash

if [ -d ./docker-entrypoint.d ];then
    for i in ./docker-entrypoint.d/*.sh;do
        bash $i
    done
fi

exec "$@"
