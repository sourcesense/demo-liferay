#!/bin/bash

# Inserire gli indirizzi ip di tutti i nodi del cluster tranne quello locale  separati da spazio
LF_NODES=() 

# Inserire il path di installazione di Tomcat (LF)
LFSRV_HOME="" 

# Indica la cartella dedicata al deploy centralizzato 
CLUSTER_DEPLOY_DIR="${LFSRV_HOME}/cluster_deploy/deploy"

# Inserire la cartella finale dove saranno installati i  plugin
LF_DEPLOY_DIR="${LFSRV_HOME}/webapps" 

##

display_usage() {
  echo "Utilizzo: $0 <options>"
  echo
  echo "Opzioni:"
  echo -e " -l, --listener \t\t\t\t\t\t Modalità ascolto sulla cartella $CLUSTER_DEPLOY_DIR ."
  echo -e " -i, --install, --deploy <application.war> \t\t Deploy plugin .war "
  echo -e " -h, --help \t\t\t\t\t\t Mostra questo messaggio."
}

deploy() {
  local opts='-az'

  rsync $opts --del "$1" "${LF_DEPLOY_DIR}" &

  for node in "${NODES[@]}"; do
    rsync $opts --del "$1" ${node}:"${LF_DEPLOY_DIR}" &
  done

  wait
}


listener_mode() {
  while true; do

    if [[ $(ls -A "${CLUSTER_DEPLOY_DIR}") ]]; then

      for app in "${CLUSTER_DEPLOY_DIR}"/*; do
        deploy "${app}" && rm -rf "${app}" || echo "Errore: impossibile eseguire il  deploy!"
      done

    fi

    sleep 5
  done
}

first_param="${@:1}"
if [[ $# -eq 0 || "${first_param:0:1}" != "-" ]]; then display_usage; exit 1; fi

SHORTOPTS="di:u:h"
LONGOPTS="daemon,install:,deploy:,help"

ARGS=$(getopt --name $0 --longoptions="$LONGOPTS" --options="$SHORTOPTS" -- "$@")
eval set -- "$ARGS"

while true; do
  case "$1" in
    -l|--listener)			listener_mode;		shift		;;
    -i|--install|--deploy)		deploy "$2";		shift 2		;;
    -h|--help)				display_usage;		exit 0		;;
    --)					shift;			break		;;
    *)					display_usage;		exit 1		;;
  esac
done
 
 