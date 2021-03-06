#!/bin/sh

if [ $# -ne 2 ]; then
  echo "Usage: $(basename $0) <heroku-app-name> <local_database_name>"
  exit -1
fi

if heroku pg:backups capture --app $1 ; then
  if curl -o latest.dump `heroku pg:backups public-url --app $1` ; then
    pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d $2 latest.dump
  fi
fi
