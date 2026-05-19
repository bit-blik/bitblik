#!/bin/sh
# Entrypoint script to generate config.js from environment variables

# Create config.js from environment variables if they are set
cat > /usr/share/nginx/html/config.js <<EOF
// Runtime configuration for group links
// Generated from environment variables at container startup
window.appConfig = {
  telegramGroupLink: '${TELEGRAM_GROUP_LINK:-}',
  elementGroupLink: '${ELEMENT_GROUP_LINK:-}',
  simplexGroupLink: '${SIMPLEX_GROUP_LINK:-}',
  signalGroupLink: '${SIGNAL_GROUP_LINK:-}'
};
EOF

# Start Nginx
exec nginx -g "daemon off;"

