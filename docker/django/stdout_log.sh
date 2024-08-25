#!/usr/bin/env bash

# nginx と wsgi のログをコンソールに出力します.
# これにより, AWS CloudWatch でログを確認できるようになります.

# Prepare log files and start outputting logs to stdout
touch ${HOME}/uwsgi.log && touch /var/log/nginx/access.log && touch /var/log/nginx/error.log

tail -f -n 0 ${HOME}/uwsgi.log | sed -u -e 's/^/[Django] /g' &
# nginx の access ログ. health_check のログは無視する
tail -f -n 0 /var/log/nginx/access.log | grep -iv "GET /health_check.html" --line-buffered | sed -u -e 's/^/[nginx_access] /g' &
tail -f -n 0 /var/log/nginx/error.log | sed -u -e 's/^/[nginx_error] /g' &
