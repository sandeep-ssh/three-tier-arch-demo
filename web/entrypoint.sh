#!/usr/bin/env bash

BASE_DIR=/usr/share/nginx/html

if [ -n "$1" ]
then
    exec "$@"
fi

if [ -n "$INSTANA_EUM_KEY" -a -n "$INSTANA_EUM_REPORTING_URL" ]
then
    echo "Enabling Instana EUM"
    result=$(curl -kv -s --connect-timeout 10 "$INSTANA_EUM_REPORTING_URL" 2>&1 | grep "301 Moved Permanently")
    if [ -n "$result" ]
    then
        echo '301 Moved Permanently found!'
        [[ "${INSTANA_EUM_REPORTING_URL}" != */ ]] && INSTANA_EUM_REPORTING_URL="${INSTANA_EUM_REPORTING_URL}/"
    fi
    sed -i "s|INSTANA_EUM_KEY|$INSTANA_EUM_KEY|" $BASE_DIR/eum-tmpl.html
    sed -i "s|INSTANA_EUM_REPORTING_URL|$INSTANA_EUM_REPORTING_URL|" $BASE_DIR/eum-tmpl.html
    cp $BASE_DIR/eum-tmpl.html $BASE_DIR/eum.html
else
    echo "EUM not enabled"
    cp $BASE_DIR/empty.html $BASE_DIR/eum.html
fi

# make sure nginx can access the eum file
chmod 644 $BASE_DIR/eum.html

# apply environment variables to default.conf
envsubst '${CATALOGUE_HOST} ${USER_HOST} ${CART_HOST} ${SHIPPING_HOST} ${PAYMENT_HOST} ${RATINGS_HOST}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

exec nginx -g "daemon off;"