#!/bin/bash
set -e

rm -f tmp/pids/server.pid
#
echo "Resetting database..."
bin/rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
bin/rails db:create
bin/rails db:migrate

echo "Checking if seeding is needed..."
if bin/rails runner "exit User.any? ? 0 : 1"; then
  echo "Skipping seeds (already seeded)"
else
  echo "Seeding database..."
  bin/rails db:seed
fi

exec "$@"
