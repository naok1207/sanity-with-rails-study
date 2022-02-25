#!/bin/sh

# heroku login
# heroku container:login
# heroku create ${APP_NAME}
# heroku addons:create heroku-postgresql:hobby-dev

# sh heroku.sh APP_NAME PostgresContainerName
APP_NAME=$1
DB_NAME=$2

heroku config:add RAILS_ENV="production"
heroku container:push web -a ${APP_NAME}
heroku container:release web -a ${APP_NAME}
heroku addons:attach ${DB_NAME} -a ${APP_NAME}
heroku run bundle exec rake db:migrate RAILE_ENV=production -a ${APP_NAME}
heroku config:add RAILS_LOG_TO_STDOUT='true' ${APP_NAME}
heroku open -a ${APP_NAME}
