#!/usr/bin/env bash

checkDir() {
    [ -d "$@" ]
} 

checkFile() {
    [ -f "$@" ]
}

checkDirAndMake() {
    if ! checkDir "$@"; then
      mkdir -p "$@"
    fi
}

WEB_DATA="/web/data"
CERT_WEBROOT="/web/cert_webroot"
WEB_NGINX_CONFIG_ENABLED="/web/config/nginx/sites-enabled"
WEB_NGINX_CONFIG_DISABLED="/web/config/nginx/sites-disabled"
SSL_DIR="/web/ssl/"
AUTORUN_PATH="/web/config/autorun.sh"


checkDirAndMake $CERT_WEBROOT
checkDirAndMake $WEB_NGINX_CONFIG_ENABLED
checkDirAndMake $WEB_NGINX_CONFIG_DISABLED
checkDirAndMake $SSL_DIR

if ! checkDir $WEB_DATA; then
    mkdir -p $WEB_DATA/default_page
    cp -r -f /config/defaults/page/webdata/* $WEB_DATA/default_page
    cp -r -f /config/defaults/page/default.conf $WEB_NGINX_CONFIG_ENABLED
    touch newinstall
fi

if ! checkFile $AUTORUN_PATH; then
    touch $AUTORUN_PATH
    echo "#!/usr/bin/env bash" >> $AUTORUN_PATH
fi