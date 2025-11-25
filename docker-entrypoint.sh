#!/bin/sh
set -e

# Check if database exists, if not copy the seed database
if [ ! -f /app/.tmp/data.db ]; then
  echo "No database found. Copying seed database with sample content..."
  cp /app/.tmp/data.db.seed /app/.tmp/data.db
  echo "Sample database copied!"
fi

# Start Strapi
echo "Starting Strapi..."
exec pnpm start
