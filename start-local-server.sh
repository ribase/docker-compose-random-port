#!/usr/bin/env bash

HTTPDEFAULT=80
MYSQLDEFAULT=3360

COUNTERHTTP=${1:-$HTTPDEFAULT}
COUNTERMYSQL=${2:-$MYSQLDEFAULT}

function determinePortHttp {
    while [ 1 ]
    do
        port=`lsof -i :${COUNTERHTTP}`
        echo "Trying ${COUNTERHTTP}"
        if [[ "$port" = *"com.docke"* ]]
        then
                COUNTERHTTP=$((COUNTERHTTP + 1))
        else
                execDocker
cat <<EOF
*************************************
** MYSQL PORT: ${COUNTERMYSQL}     **
** HTTP PORT: ${COUNTERHTTP}       **
*************************************
EOF
                exit
        fi
    done
}

function determinePortMysql {
    while [ 1 ]
    do
        port=`lsof -i :${COUNTERMYSQL}`
        echo "Trying ${COUNTERMYSQL}"
        if [[ "$port" = *"com.docke"* ]]
        then
                COUNTERMYSQL=$((COUNTERMYSQL + 1))
        else
                determinePortHttp
        fi
    done
}


function execDocker {
cat <<EOF
    ██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ ███╗   ███╗ █████╗  ██████╗ ██╗ ██████╗
    ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔════╝ ██║██╔════╝
    ██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝██╔████╔██║███████║██║  ███╗██║██║
    ██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║██║   ██║██║██║
    ██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║██║ ╚═╝ ██║██║  ██║╚██████╔╝██║╚██████╗
    ╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝ ╚═════╝
EOF

    PORT=${COUNTERHTTP} MYSQL=${COUNTERMYSQL} docker-compose up --build --remove-orphans  -d

    echo "Add host to /etc/hosts"

    if grep -q "www.docker.local" /etc/hosts; then
        echo "Exists"
    else
        sudo bash -c "echo '127.0.0.1     www.docker.local' >> /etc/hosts"
    fi
}

determinePortMysql
